#import "HookHelper.h"

#import "SQLiteStorage.h"
#import "ThreadStorage.h"
#import "callLogManager.h"
#import <vector>
#import <string>
#import <pthread.h>
#import <pthread.h>
#import "Config.h"
#import "HookHelper.h"
#import <semaphore.h>
#import <CydiaSubstrate/CydiaSubstrate.h>

using namespace std;

pthread_mutex_t dispatched_blocks_mutex;
vector<uint32_t> dispatched_blocks;

void ____dispatch_async(dispatch_queue_t queue, dispatch_block_t block);

void _____dispatch_call_block_and_release(void * a, void * b);

void (*original_dispatch_async)(dispatch_queue_t, dispatch_block_t);
void (*original__dispatch_call_block_and_release)(void *, void *);
__attribute__((constructor))
static void initialize() {
//    dispatch_async(dispatch_get_main_queue(), ^ {
        pthread_mutex_init(&dispatched_blocks_mutex, 0);
//        MSHookFunction((void*)&dispatch_async, (void*)&____dispatch_async, (void**)&original_dispatch_async);
        void *dispatch_async_symbol = 0;
        MSHookSymbol(dispatch_async_symbol, "_dispatch_async");
        MSHookFunction(dispatch_async_symbol, (void*)&____dispatch_async, (void**)&original_dispatch_async);
        
        void *_dispatch_call_block_and_release_symbol = 0;
        MSHookSymbol(_dispatch_call_block_and_release_symbol, "__dispatch_call_block_and_release");
        MSHookFunction(_dispatch_call_block_and_release_symbol, (void*)&_____dispatch_call_block_and_release, (void**)&original__dispatch_call_block_and_release);
//    });
}



__attribute__((constructor))
static void constructor() {
}
void ____dispatch_async(dispatch_queue_t queue, dispatch_block_t block)
{
    if (!is_enabled() || !enabled_) {
        original_dispatch_async(queue, block);
        return;
    }
    
    thread_storage_t *thread_infos = get_thread_infos();
    if (thread_infos->parse_enabled_stack->size() && thread_infos->parse_enabled_stack->back()) {
        pthread_mutex_lock(&dispatched_blocks_mutex);
        dispatched_blocks.push_back((uint32_t)block);
        pthread_mutex_unlock(&dispatched_blocks_mutex);
    }
    
    original_dispatch_async(queue, block);
}


void _____dispatch_call_block_and_release(void * a, void * b)
{
    if (!is_enabled() || !enabled_) {
        original__dispatch_call_block_and_release(a, b);
        return;
    }
    pthread_mutex_lock(&dispatched_blocks_mutex);
    vector<uint32_t>::iterator it = std::find(dispatched_blocks.begin(), dispatched_blocks.end(), (uint32_t)a);
    if (it == dispatched_blocks.end()) {
        pthread_mutex_unlock(&dispatched_blocks_mutex);
        original__dispatch_call_block_and_release(a, b);
        return;
    }
    dispatched_blocks.erase(it);
    pthread_mutex_unlock(&dispatched_blocks_mutex);
    thread_storage_t *thread_infos = get_thread_infos();
    set_enabled(false);
    call_id_t call_id;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    call_id = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(call_id);
    thread_infos->parse_enabled_stack->push_back(true);
    parameter_t *parameters = NULL;
    parameters = (parameter_t*)calloc(2, sizeof(parameter_t));
//Parse parameter a
    parameters[0].description = NULL;
    strncpy(parameters[0].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[0].value, MAX_VALUE_LENGTH, "0x%X", (register_t)a);
//Parse parameter b
    parameters[1].description = NULL;
    strncpy(parameters[1].type, "^void", MAX_TYPE_LENGTH);
    snprintf(parameters[1].value, MAX_VALUE_LENGTH, "0x%X", (register_t)b);
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            set_enabled(false);
            insert_call(call_id, caller_id, "dispatch", "_dispatch_call_block_and_release", "0x0", parameters, 2);
            for(unsigned int i = 0; i < 2; ++i) {
                if (parameters[i].description != NULL) {
                    free(parameters[i].description);
                }
            }
            free(parameters);
            set_enabled(true);
        });
    } else {
        for(unsigned int i = 0; i < 2; ++i) {
            if (parameters[i].description != NULL) {
                free(parameters[i].description);
            }
        }
        free(parameters);
    }
    set_enabled(true);
    original__dispatch_call_block_and_release(a, b);
    set_enabled(false);
    thread_infos->call_id_stack->pop_back();
    thread_infos->parse_enabled_stack->pop_back();
    set_enabled(true);
}


