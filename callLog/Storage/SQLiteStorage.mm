//Copyright (c) 2015, David Missmann
//All rights reserved.
//
//Redistribution and use in source and binary forms, with or without modification,
//are permitted provided that the following conditions are met:
//
//1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following
//disclaimer.
//
//2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
//disclaimer in the documentation and/or other materials provided with the distribution.
//
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
//INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
//WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "SQLiteStorage.h"

#import "sqlite3.h"
#import <string>
#import <sstream>
#import <json/json.h>

using namespace std;
using namespace Json;

const string DB_FILENAME = "argTracer.sqlite";
unsigned int remaining_operations = 0;

sqlite3 *db;

#define OPERATIONS_PER_TRANSACTION 1000
#define OPERATION_DONE() if (remaining_operations == 0) { sqlite3_exec(db, "COMMIT TRANSACTION;", 0, 0, 0); sqlite3_exec(db, "BEGIN TRANSACTION;", 0, 0, 0); remaining_operations = OPERATIONS_PER_TRANSACTION; }remaining_operations--;

void initialize_database()
{
    NSString *db_file = get_db_path();
    
    [[NSFileManager defaultManager] removeItemAtPath:db_file
                                               error:nil];
    
    if (!db_open()) {
        return;
    }
    
    NSLog(@"DB path %s", [db_file UTF8String]);
    
    char *error_msg = 0;
    
    sqlite3_exec(db, "CREATE TABLE CallInfo (\
                 ID INTEGER,\
                 CallerID INTEGER,\
                 Class TEXT,\
                 Method TEXT,\
                 Self TEXT\
                 );\
                 CREATE Table Return (\
                 CallID INTEGER,\
                 Type TEXT,\
                 Value TEXT,\
                 Description\
                 );\
                 \
                 CREATE TABLE Parameter (\
                 CallID INTEGER,\
                 Num INTEGER,\
                 Type TEXT,\
                 Value TEXT,\
                 Description TEXT,\
                 Name TEXT\
                 );\
                 \
                 CREATE TABLE Class (\
                 ID INTEGER,\
                 Name TEXT,\
                 Super TEXT,\
                 Bundle TEXT\
                 );\
                 \
                 CREATE TABLE Method (\
                 ClassID INTEGER,\
                 Name TEXT\
                 );\
                 \
                 CREATE VIEW Call AS \
                 SELECT CallInfo.ID, CallInfo.CallerID, CallInfo.Class, CallInfo.Method, CallInfo.Self, \
                 Return.Type AS ReturnType, Return.Value AS ReturnValue, IFNULL(Return.Description, '') AS ReturnDescription \
                 FROM CallInfo LEFT OUTER JOIN Return ON CallInfo.ID = Return.CallID;\
                 \
                 CREATE VIEW CompleteCall AS \
                 SELECT * FROM Call LEFT OUTER JOIN Parameter \
                 ON Call.ID = Parameter.CallID;",
                 0,
                 0,
                 &error_msg);
    
    if (error_msg) {
        NSLog(@"Cannot init db: %s", error_msg);
    }
    
#ifdef SQL_SYNC
    sqlite3_exec(db, "PRAGMA synchronous = FULL", NULL, NULL, &error_msg);
    sqlite3_exec(db, "PRAGMA journal_mode = OFF", NULL, NULL, &error_msg);
#else
    sqlite3_exec(db, "PRAGMA synchronous = FULL", NULL, NULL, &error_msg);
//    sqlite3_exec(db, "PRAGMA journal_mode = MEMORY", NULL, NULL, &error_msg);
    sqlite3_exec(db, "PRAGMA journal_mode = WAL", NULL, NULL, &error_msg);
//    sqlite3_exec(db, "PRAGMA temp_store=MEMORY", NULL, NULL, &error_msg);
//    sqlite3_exec(db, "PRAGMA count_changes=OFF", NULL, NULL, &error_msg);
//    sqlite3_exec(db, "PRAGMA locking_mode = EXCLUSIVE", NULL, NULL, &error_msg);
//    sqlite3_exec(db, "PRAGMA auto_vacuum = OFF", NULL, NULL, &error_msg);
#endif
//    sqlite3_exec(db, "PRAGMA synchronous = FULL", NULL, NULL, &error_msg);
//    sqlite3_exec(db, "PRAGMA journal_mode = OFF", NULL, NULL, &error_msg);
//    sqlite3_exec(db, "PRAGMA journal_mode = MEMORY", NULL, NULL, &error_msg);
//    sqlite3_exec(db, "PRAGMA journal_mode = WAL", NULL, NULL, &error_msg);
    
    sqlite3_exec(db, "BEGIN TRANSACTION;", 0, 0, 0);
}

bool db_open()
{
    NSString *db_file = get_db_path();
    if (sqlite3_open([db_file UTF8String], &db) != SQLITE_OK) {
        NSLog(@"Cannot open database");
        return false;
    }
    return true;
}

void db_close()
{
    int r = sqlite3_close(db);
    while (r != SQLITE_OK) {
        sleep(2);
        r = sqlite3_close(db);
    }
}

NSString *get_db_path()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *db_file = [NSString stringWithFormat:@"%@/%s",
                         documentsDirectory, DB_FILENAME.c_str()];

    return db_file;
}

void insert_call(const call_id_t call_id,
                 const call_id_t caller_id,
                 const char *clazz,
                 const char *method,
                 const char *self,
                 const parameter_t *parameter,
                 const size_t num_parameters)
{

    sqlite3_stmt *call_stmt;
    sqlite3_prepare_v2(db,
                       "INSERT INTO CallInfo(ID, CallerID, Class, Method, Self) VALUES(?, ?, ?, ?, ?);",
                       -1,
                       &call_stmt,
                       NULL);
    
    sqlite3_bind_int64(call_stmt,
                       1,
                       call_id);
    
    sqlite3_bind_int64(call_stmt,
                       2,
                       caller_id);
    
    sqlite3_bind_text(call_stmt,
                      3,
                      clazz,
                      strlen(clazz),
                      NULL);
    sqlite3_bind_text(call_stmt,
                      4,
                      method,
                      strlen(method),
                      NULL);
    sqlite3_bind_text(call_stmt,
                      5,
                      self,
                      strlen(self),
                      NULL);
    int result = 0;
    if ((result = sqlite3_step(call_stmt)) != SQLITE_DONE) {
        NSLog(@"SQLite error: %d %s", result, sqlite3_errmsg(db));
    }
    sqlite3_finalize(call_stmt);
    
    
    for (int i = 0; i < num_parameters; ++i) {
        sqlite3_stmt *arg_stmt = NULL;
        
        string arg_num = to_string(i);
        
        sqlite3_prepare_v2(db,
                           "INSERT INTO Parameter(CallID, Num, Type, Value, Description) VALUES(?, ?, ?, ?, ?);",
                           -1,
                           &arg_stmt,
                           NULL);
        
        parameter_t p = parameter[i];
        
        sqlite3_bind_int64(arg_stmt,
                           1,
                           call_id);
        
        sqlite3_bind_text(arg_stmt,
                          2,
                          arg_num.c_str(),
                          arg_num.length(),
                          NULL);
        
        sqlite3_bind_text(arg_stmt,
                          3,
                          p.type,
                          strnlen(p.type, MAX_TYPE_LENGTH),
                          NULL);
        
        sqlite3_bind_text(arg_stmt,
                          4,
                          p.value,
                          strnlen(p.value, MAX_VALUE_LENGTH),
                          NULL);
        
        sqlite3_bind_text(arg_stmt,
                          5,
                          p.description,
                          p.description ? strlen(p.description) : 0,
                          NULL);
        sqlite3_step(arg_stmt);
        sqlite3_finalize(arg_stmt);
    }
    
    OPERATION_DONE();

}

void insert_return(const call_id_t call_id,
                   const parameter_t *return_parameter)
{
    
    sqlite3_stmt *stmt = NULL;
    
    
    sqlite3_prepare(db,
                    "INSERT INTO Return(CallID, Type, Value, Description) Values(?, ?, ?, ?);",
                    -1,
                    &stmt,
                    NULL);
    
    sqlite3_bind_int64(stmt,
                       1,
                       call_id);
    
    sqlite3_bind_text(stmt,
                      2,
                      return_parameter->type,
                      strnlen(return_parameter->type, MAX_TYPE_LENGTH),
                      NULL);
    sqlite3_bind_text(stmt,
                      3,
                      return_parameter->value,
                      strnlen(return_parameter->value, MAX_VALUE_LENGTH),
                      NULL);
    if (return_parameter->description) {
        sqlite3_bind_text(stmt,
                          4,
                          return_parameter->description,
                          return_parameter->description ? strlen(return_parameter->description) : 0,
                          NULL);
    } else {
        sqlite3_bind_null(stmt,
                          4);
    }
    

    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    
    OPERATION_DONE();
}

void insert_class(int class_id, string clazz, string super_class, std::string bundle)
{
    sqlite3_stmt *stmt;
    
    sqlite3_prepare_v2(db,
                       "INSERT INTO Class(ID, Name, Super, Bundle) VALUES(?, ?, ?, ?);",
                       -1,
                       &stmt,
                       NULL);
    
    sqlite3_bind_int(stmt,
                     1,
                     class_id);
    
    sqlite3_bind_text(stmt,
                      2,
                      clazz.c_str(),
                      clazz.length(),
                      NULL);
    sqlite3_bind_text(stmt,
                      3,
                      super_class.c_str(),
                      super_class.length(),
                      NULL);
    sqlite3_bind_text(stmt,
                      4,
                      bundle.c_str(),
                      bundle.length(),
                      NULL);
    
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    
    OPERATION_DONE();
}

void insert_method(int class_id, string method)
{
    sqlite3_stmt *stmt;
    
    sqlite3_prepare_v2(db,
                       "INSERT INTO Method(ClassID, Name) VALUES(?, ?);",
                       -1,
                       &stmt,
                       NULL);
    
    sqlite3_bind_int(stmt,
                     1,
                     class_id);
    
    sqlite3_bind_text(stmt,
                      2,
                      method.c_str(),
                      method.length(),
                      NULL);
    
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    
    OPERATION_DONE();
}


Value get_method_list()
{
    sqlite3_stmt *stmt;
    
    if (sqlite3_prepare_v2(db,
                       "SELECT Call.ClassName, Call.MethodName\
                        FROM Call\
                        GROUP BY Call.ClassName, Call.MethodName\
                        ORDER BY Call.ClassName, Call.MethodName;",
                       -1,
                       &stmt,
                           NULL) != SQLITE_OK) {
        printf("%s", sqlite3_errmsg(db));
    }
    
    Value list;

    
    while (1) {
        int r  = sqlite3_step(stmt);
        if (r == SQLITE_ROW) {
            const char *clazz = (char *)sqlite3_column_text(stmt, 0);
            const char *method = (char *)sqlite3_column_text(stmt, 1);

            Value call;
            call["class"] = clazz;
            call["method"] = method;
            
            list.append(call);
        } else if (r == SQLITE_DONE) {
            break;
        } else {
            printf("%s", sqlite3_errmsg(db));
        }
    }
    
    sqlite3_finalize(stmt);
    
    return list;
}


Value get_call_backtrace(string call_id, string arg_value)
{
    sqlite3_stmt *stmt;
    
    if (arg_value.length()) {
        sqlite3_prepare_v2(db,
                           "WITH RECURSIVE call_list (call_id, caller_id, classname, methodname) AS (\
                           SELECT CallID AS call_id,\
                           CallerID as caller_id,\
                           ClassName as classname,\
                           MethodName as methodname\
                           FROM Call WHERE Call.CallID LIKE ?\
                           UNION ALL\
                           SELECT Call.CallID, Call.CallerID, Call.ClassName, Call.MethodName\
                           FROM Call INNER JOIN call_list ON Call.CallID = call_list.caller_id\
                           )\
                           SELECT call_list.call_id FROM call_list LEFT OUTER JOIN Argument ON call_list.call_id = Argument.CallID \
                           INNER JOIN ReturnValue ON ReturnValue.CallID = call_list.call_id\
                           WHERE Argument.value LIKE ? OR ReturnValue.value LIKE ?\
                           ORDER BY call_list.call_id DESC",
                           -1,
                           &stmt,
                           NULL);
        
        sqlite3_bind_text(stmt,
                          1,
                          call_id.c_str(),
                          call_id.length(),
                          NULL);
        
        sqlite3_bind_text(stmt,
                          2,
                          arg_value.c_str(),
                          arg_value.length(),
                          NULL);
        
        sqlite3_bind_text(stmt,
                          3,
                          arg_value.c_str(),
                          arg_value.length(),
                          NULL);
    } else {
        sqlite3_prepare_v2(db,
                           "WITH RECURSIVE call_list (call_id, caller_id, classname, methodname) AS (\
                           SELECT CallID AS call_id,\
                           CallerID as caller_id,\
                           ClassName as classname,\
                           MethodName as methodname\
                           FROM Call WHERE Call.CallID LIKE ?\
                           UNION ALL\
                           SELECT Call.CallID, Call.CallerID, Call.ClassName, Call.MethodName\
                           FROM Call INNER JOIN call_list ON Call.CallID = call_list.caller_id\
                           )\
                           SELECT call_list.call_id FROM call_list LEFT OUTER JOIN Argument ON call_list.call_id = Argument.CallID \
                           INNER JOIN ReturnValue ON ReturnValue.CallID = call_list.call_id\
                           GROUP BY call_list.call_id \
                           ORDER BY call_list.call_id DESC",
                           -1,
                           &stmt,
                           NULL);
        
        sqlite3_bind_text(stmt,
                          1,
                          call_id.c_str(),
                          call_id.length(),
                          NULL);
    }

    
    Value calls;
    string last_caller_id = "";
    while (1) {
        int r = sqlite3_step(stmt);
        if (r == SQLITE_ROW) {
            string current_call_id = (char *)sqlite3_column_text(stmt, 0);
            Value c = get_call(current_call_id);
            last_caller_id = c["callerID"].asString();
            
            if (current_call_id == call_id) {
                continue;
            }
            calls.append(get_call(current_call_id));
        } else if (r == SQLITE_DONE) {
            break;
        } else if (r == SQLITE_MISUSE) {
            printf("%s\n", sqlite3_errmsg(db));
        }
        //TODO: error handling
    }
    
    Value last = calls.get(calls.size() - 1, Value());
    Value last_caller = get_call(last_caller_id);
    if (last_caller.isMember("callID")) {
        calls.append(last_caller);
    }
    
    return calls;
}

Value get_call(string call_id)
{
    sqlite3_stmt *stmt;
    
    sqlite3_prepare_v2(db,
                       "SELECT Call.CallID,\
                       Call.CallerID,\
                       Call.ClassName,\
                       Call.MethodName,\
                       Call.Self,\
                       Argument.ArgNum,\
                       Argument.Type,\
                       Argument.Value,\
                       Argument.Description,\
                       ReturnValue.Type,\
                       ReturnValue.Value,\
                       ReturnValue.Description\
                       FROM Call LEFT OUTER JOIN Argument ON Call.CallID = Argument.CallID \
                       INNER JOIN ReturnValue ON Call.CallID = ReturnValue.CallID \
                       WHERE Call.CallID LIKE ?\
                       ORDER BY Argument.ArgNum;",
                       -1,
                       &stmt,
                       NULL);
    
    sqlite3_bind_text(stmt,
                      1,
                      call_id.c_str(),
                      call_id.length(),
                      NULL);
    

    Value call;
    Value arguments;
    
    bool call_infos = false;
    
    while (1) {
        int r = sqlite3_step(stmt);
        if (r == SQLITE_ROW) {
            
            if (!call_infos) {
                const char *caller_id = (char *)sqlite3_column_text(stmt, 1);
                const char *class_name = (char*)sqlite3_column_text(stmt, 2);
                const char *method_name = (char*)sqlite3_column_text(stmt, 3);
                const char *self = (char*)sqlite3_column_text(stmt, 4);
                const char *return_type = (char*)sqlite3_column_text(stmt, 9);
                const char *return_value = (char*)sqlite3_column_text(stmt, 10);
                const char *return_desc = (char*)sqlite3_column_text(stmt, 11);
                
                call["callID"] = call_id;
                call["callerID"] = caller_id;
                call["class"] = class_name;
                call["method"] = method_name;
                call["self"] = self;
                call["returnType"] = return_type;
                call["returnValue"] = return_value;
                call["returnDescription"] = return_desc;
                
                call_infos = true;
            }
            
            const char *arg_num = (char*)sqlite3_column_text(stmt, 5);
            const char *arg_type = (char*)sqlite3_column_text(stmt, 6);
            const char *arg_value = (char*)sqlite3_column_text(stmt, 7);
            const char *arg_desc = (char*)sqlite3_column_text(stmt, 8);
            
            if (arg_num) {
                Value arg;
                arg["num"] = arg_num;
                arg["type"] = arg_type;
                arg["value"] = arg_value;
                arg["description"] = arg_desc;
                
                arguments.append(arg);
            }
            
        } else if (r == SQLITE_DONE) {
            break;
        }
    }
    
    call["arguments"] = arguments;
    
    return call;
}

Value find_in_return(string call_id, string arg_value)
{
    sqlite3_stmt *stmt;
    
    sqlite3_prepare_v2(db,
                       "SELECT Call.CallID \
                       FROM Call LEFT OUTER JOIN Argument ON Call.CallID = Argument.CallID \
                       INNER JOIN ReturnValue ON Call.CallID = ReturnValue.CallID \
                       WHERE (Argument.Value LIKE ? OR ReturnValue.Value LIKE ?) \
                       AND Call.CallerID LIKE ? \
                       GROUP BY Call.CallID;",
                       -1,
                       &stmt,
                       NULL);
    
    sqlite3_bind_text(stmt,
                      1,
                      arg_value.c_str(),
                      arg_value.length(),
                      NULL);
    sqlite3_bind_text(stmt,
                      2,
                      arg_value.c_str(),
                      arg_value.length(),
                      NULL);
    sqlite3_bind_text(stmt,
                      3,
                      call_id.c_str(),
                      call_id.length(),
                      NULL);
    
    
    Value calls;
    
    while (1) {
        int r = sqlite3_step(stmt);
        
        if (r == SQLITE_ROW) {
            const char *call_id = (char *)sqlite3_column_text(stmt, 0);
            calls.append(get_call(call_id));
        } else if (r == SQLITE_DONE) {
            break;
        }
    }
    return calls;
}

Value find_calls(std::string clazz,
                 std::string method,
                 std::string value,
                 std::string description)
{
    sqlite3_stmt *stmt;
    
    sqlite3_prepare_v2(db,
                       "SELECT Call.CallID,\
                       Call.CallerID,\
                       Call.ClassName,\
                       Call.MethodName,\
                       Call.Self,\
                       Argument.ArgNum,\
                       Argument.Type,\
                       Argument.Value,\
                       Argument.Description,\
                       ReturnValue.Type,\
                       ReturnValue.Value,\
                       ReturnValue.Description \
                       FROM \
                       (SELECT Call.CallID AS CallID \
                        FROM Call LEFT OUTER JOIN Argument ON Call.CallID = Argument.CallID \
                        INNER JOIN ReturnValue ON Call.CallID = ReturnValue.CallID \
                        WHERE (Argument.Value LIKE ? OR ReturnValue.Value LIKE ?) \
                        AND (Argument.Description LIKE ? OR ReturnValue.description LIKE ?) \
                        GROUP BY Call.CallID) AS f \
                       INNER JOIN Call ON f.CallID = Call.CallID \
                       LEFT OUTER JOIN Argument ON Call.CallID = Argument.CallID \
                       INNER JOIN ReturnValue ON Call.CallID = ReturnValue.CallID \
                       WHERE Call.ClassName LIKE ? AND Call.MethodName LIKE ? \
                       ORDER BY Call.CallID DESC, Argument.ArgNum;",
                       -1,
                       &stmt,
                       NULL);
    
    
    if (!value.length()) {
        value = "%";
    }
    if (!description.length()) {
        description = "%";
    }
    
    sqlite3_bind_text(stmt,
                      1,
                      value.c_str(),
                      value.length(),
                      NULL);
    sqlite3_bind_text(stmt,
                      2,
                      value.c_str(),
                      value.length(),
                      NULL);
    sqlite3_bind_text(stmt,
                      3,
                      description.c_str(),
                      description.length(),
                      NULL);
    sqlite3_bind_text(stmt,
                      4,
                      description.c_str(),
                      description.length(),
                      NULL);
    sqlite3_bind_text(stmt,
                      5,
                      clazz.c_str(),
                      clazz.length(),
                      NULL);
    sqlite3_bind_text(stmt,
                      6,
                      method.c_str(),
                      method.length(),
                      NULL);

    
    Value calls;
    
    Value current_call;
    Value current_arguments;
    string current_call_id = "";
    bool call_infos = false;
    
    while (1) {
        int r = sqlite3_step(stmt);
        
        if (r == SQLITE_ROW) {
            const char *call_id = (char *)sqlite3_column_text(stmt, 0);
            
            if (current_call_id != string(call_id)) {
                if (current_call.isMember("callID")) {
                    current_call["arguments"] = current_arguments;
                    calls.append(current_call);
                    current_call = Value();
                    current_arguments = Value();
                    call_infos = false;
                    
                }
                current_call_id = call_id;
            }
            if (!call_infos) {
                const char *caller_id = (char *)sqlite3_column_text(stmt, 1);
                const char *class_name = (char*)sqlite3_column_text(stmt, 2);
                const char *method_name = (char*)sqlite3_column_text(stmt, 3);
                const char *self = (char*)sqlite3_column_text(stmt, 4);
                const char *return_type = (char*)sqlite3_column_text(stmt, 9);
                const char *return_value = (char*)sqlite3_column_text(stmt, 10);
                const char *return_desc = (char*)sqlite3_column_text(stmt, 11);
                
                current_call["callID"] = call_id;
                current_call["callerID"] = caller_id;
                current_call["class"] = class_name;
                current_call["method"] = method_name;
                current_call["self"] = self;
                current_call["returnType"] = return_type;
                current_call["returnValue"] = return_value;
                current_call["returnDescription"] = return_desc;
                
                call_infos = true;
            }
            

            
            const char *arg_num = (char*)sqlite3_column_text(stmt, 5);
            const char *arg_type = (char*)sqlite3_column_text(stmt, 6);
            const char *arg_value = (char*)sqlite3_column_text(stmt, 7);
            const char *arg_desc = (char*)sqlite3_column_text(stmt, 8);
            
            if (arg_num) {
                Value arg;
                arg["num"] = arg_num;
                arg["type"] = arg_type;
                arg["value"] = arg_value;
                arg["description"] = arg_desc;
                
                current_arguments.append(arg);
            }
            
            
        } else if (r == SQLITE_DONE) {
            current_call["arguments"] = current_arguments;
            calls.append(current_call);
            break;
        } else if (r == SQLITE_MISUSE) {
            printf("%s\n", sqlite3_errmsg(db));
            break;
        }
    }
    
    return calls;
}

Value get_called(string call_id) {
    sqlite3_stmt *stmt;
    
    sqlite3_prepare_v2(db,
                       "SELECT Call.CallID \
                       FROM Call \
                       WHERE Call.CallerID LIKE ?;",
                       -1,
                       &stmt,
                       NULL);
    sqlite3_bind_text(stmt,
                      1,
                      call_id.c_str(),
                      call_id.length(),
                      NULL);
    Value calls;
    
    while (1) {
        int r = sqlite3_step(stmt);
        
        if (r == SQLITE_ROW) {
            const char *call_id = (char*) sqlite3_column_text(stmt, 0);
            Value call = get_call(call_id);
            calls.append(call);
        } else if (r == SQLITE_DONE) {
            break;
        }
    }
    return calls;
}