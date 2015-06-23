#import "HookHelper.h"

#import "SQLiteStorage.h"
#import "ThreadStorage.h"
#import <vector>
#import <string>
#import <pthread.h>
#import <pthread.h>
#import "Config.h"
#import <CydiaSubstrate/CydiaSubstrate.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonRandom.h>

using namespace std;
CCCryptorStatus ____CCCryptorCreate(CCOperation op, CCAlgorithm alg, CCOptions options, const void * key, size_t keyLength, const void * iv, CCCryptorRef * cryptorRef);

CCCryptorStatus ____CCCryptorFinal(CCCryptorRef cryptorRef, void * dataOut, size_t dataOutAvailable, size_t * dataOutMoved);

CCCryptorStatus ____CCCryptorCreateFromData(CCOperation op, CCAlgorithm alg, CCOptions options, const void * key, size_t keyLength, const void * iv, const void * data, size_t dataLength, CCCryptorRef * cryptorRef, size_t * dataUsed);

CCCryptorStatus ____CCCryptorCreateWithMode(CCOperation op, CCMode mode, CCAlgorithm alg, CCPadding padding, const void * iv, const void * key, size_t keyLength, const void * tweak, size_t tweakLength, int numRounds, CCModeOptions options, CCCryptorRef * cryptorRef);

CCCryptorStatus ____CCCryptorRelease(CCCryptorRef cryptorRef);

CCCryptorStatus ____CCCrypt(CCOperation op, CCAlgorithm alg, CCOptions options, const void * key, size_t keyLength, const void * iv, const void * dataIn, size_t dataInLength, void * dataOut, size_t dataOutAvailable, size_t * dataOutMoved);

CCCryptorStatus ____CCCryptorUpdate(CCCryptorRef cryptorRef, const void * dataIn, size_t dataInLength, void * dataOut, size_t dataOutAvailable, size_t * dataOutMoved);

uint ____CCCalibratePBKDF(CCPBKDFAlgorithm algorithm, size_t passwordLen, size_t saltLen, CCPseudoRandomAlgorithm prf, size_t derivedKeyLen, uint32_t msec);

int ____CCKeyDerivationPBKDF(CCPBKDFAlgorithm algorithm, const char * password, size_t passwordLen, const uint8_t * salt, size_t saltLen, CCPseudoRandomAlgorithm prf, uint rounds, uint8_t * derivedKey, size_t derivedKeyLen);

CCRNGStatus ____CCRandomGenerateBytes(void * bytes, size_t count);

CCCryptorStatus (*original_CCCryptorCreate)(CCOperation, CCAlgorithm, CCOptions, const void *, size_t, const void *, CCCryptorRef *);
CCCryptorStatus (*original_CCCryptorFinal)(CCCryptorRef, void *, size_t, size_t *);
CCCryptorStatus (*original_CCCryptorCreateFromData)(CCOperation, CCAlgorithm, CCOptions, const void *, size_t, const void *, const void *, size_t, CCCryptorRef *, size_t *);
CCCryptorStatus (*original_CCCryptorCreateWithMode)(CCOperation, CCMode, CCAlgorithm, CCPadding, const void *, const void *, size_t, const void *, size_t, int, CCModeOptions, CCCryptorRef *);
CCCryptorStatus (*original_CCCryptorRelease)(CCCryptorRef);
CCCryptorStatus (*original_CCCrypt)(CCOperation, CCAlgorithm, CCOptions, const void *, size_t, const void *, const void *, size_t, void *, size_t, size_t *);
CCCryptorStatus (*original_CCCryptorUpdate)(CCCryptorRef, const void *, size_t, void *, size_t, size_t *);
uint (*original_CCCalibratePBKDF)(CCPBKDFAlgorithm, size_t, size_t, CCPseudoRandomAlgorithm, size_t, uint32_t);
int (*original_CCKeyDerivationPBKDF)(CCPBKDFAlgorithm, const char *, size_t, const uint8_t *, size_t, CCPseudoRandomAlgorithm, uint, uint8_t *, size_t);
CCRNGStatus (*original_CCRandomGenerateBytes)(void *, size_t);
__attribute__((constructor))
static void initialize() {
    MSHookFunction((void*)&CCCryptorCreate, (void*)&____CCCryptorCreate, (void**)&original_CCCryptorCreate);
    MSHookFunction((void*)&CCCryptorFinal, (void*)&____CCCryptorFinal, (void**)&original_CCCryptorFinal);
    MSHookFunction((void*)&CCCryptorCreateFromData, (void*)&____CCCryptorCreateFromData, (void**)&original_CCCryptorCreateFromData);
    MSHookFunction((void*)&CCCryptorCreateWithMode, (void*)&____CCCryptorCreateWithMode, (void**)&original_CCCryptorCreateWithMode);
    MSHookFunction((void*)&CCCryptorRelease, (void*)&____CCCryptorRelease, (void**)&original_CCCryptorRelease);
    MSHookFunction((void*)&CCCrypt, (void*)&____CCCrypt, (void**)&original_CCCrypt);
    MSHookFunction((void*)&CCCryptorUpdate, (void*)&____CCCryptorUpdate, (void**)&original_CCCryptorUpdate);
    MSHookFunction((void*)&CCCalibratePBKDF, (void*)&____CCCalibratePBKDF, (void**)&original_CCCalibratePBKDF);
    MSHookFunction((void*)&CCKeyDerivationPBKDF, (void*)&____CCKeyDerivationPBKDF, (void**)&original_CCKeyDerivationPBKDF);
    MSHookFunction((void*)&CCRandomGenerateBytes, (void*)&____CCRandomGenerateBytes, (void**)&original_CCRandomGenerateBytes);
}

CCCryptorStatus ____CCCryptorCreate(CCOperation op, CCAlgorithm alg, CCOptions options, const void * key, size_t keyLength, const void * iv, CCCryptorRef * cryptorRef)
{
    thread_storage_t *thread_infos = get_thread_infos();
    call_id_t callID;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    callID = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(callID);
    vector<argument_t> args;
    argument_t op_arg;
    op_arg.type = "CCOperation";
    switch (op) {
    case 0:
        op_arg.description = "kCCEncrypt";
        break;
    case 1:
        op_arg.description = "kCCDecrypt";
        break;
    }
    char op_value[200];
    snprintf(op_value, 200, "%d", (int)op);
    op_arg.value = op_value;
    args.push_back(op_arg);

    argument_t alg_arg;
    alg_arg.type = "CCAlgorithm";
    switch (alg) {
    case 0:
        alg_arg.description = "kCCAlgorithmAES128";
        break;
    case 1:
        alg_arg.description = "kCCAlgorithmDES";
        break;
    case 2:
        alg_arg.description = "kCCAlgorithm3DES";
        break;
    case 3:
        alg_arg.description = "kCCAlgorithmCAST";
        break;
    case 4:
        alg_arg.description = "kCCAlgorithmRC4";
        break;
    case 5:
        alg_arg.description = "kCCAlgorithmRC2";
        break;
    case 6:
        alg_arg.description = "kCCAlgorithmBlowfish";
        break;
    }
    char alg_value[200];
    snprintf(alg_value, 200, "%d", (int)alg);
    alg_arg.value = alg_value;
    args.push_back(alg_arg);

    argument_t options_arg;
    options_arg.type = "CCOptions";
    char options_value[200];
    snprintf(options_value, 200, "%d", (int)options);
    options_arg.value = options_value;
    args.push_back(options_arg);

    argument_t key_arg;
    key_arg.type = "^void";
    char key_value[200];
    snprintf(key_value, 200, "0x%X", (register_t)key);
    key_arg.value = key_value;
    args.push_back(key_arg);

    argument_t keyLength_arg;
    keyLength_arg.type = "size_t";
    char keyLength_value[200];
    snprintf(keyLength_value, 200, "%d", (int)keyLength);
    keyLength_arg.value = keyLength_value;
    args.push_back(keyLength_arg);

    argument_t iv_arg;
    iv_arg.type = "^void";
    char iv_value[200];
    snprintf(iv_value, 200, "0x%X", (register_t)iv);
    iv_arg.value = iv_value;
    args.push_back(iv_arg);

    argument_t cryptorRef_arg;
    cryptorRef_arg.type = "^CCCryptorRef";
    char cryptorRef_value[200];
    snprintf(cryptorRef_value, 200, "0x%X", (register_t)cryptorRef);
    cryptorRef_arg.value = cryptorRef_value;
    args.push_back(cryptorRef_arg);

    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_call(to_string(callID), to_string(caller_id), "CommonCrypto", "CCCryptorCreate", "0x0", args);
        });
    }
    CCCryptorStatus return_value =     original_CCCryptorCreate(op, alg, options, key, keyLength, iv, cryptorRef);
    argument_t return_value_arg;
    return_value_arg.type = "CCCryptorStatus";
    switch (return_value) {
    case 0:
        return_value_arg.description = "kCCSuccess";
        break;
    case -4300:
        return_value_arg.description = "kCCParamError";
        break;
    case -4301:
        return_value_arg.description = "kCCBufferTooSmall";
        break;
    case -4302:
        return_value_arg.description = "kCCMemoryFailure";
        break;
    case -4303:
        return_value_arg.description = "kCCAlignmentError";
        break;
    case -4304:
        return_value_arg.description = "kCCDecodeError";
        break;
    case -4305:
        return_value_arg.description = "kCCUnimplemented";
        break;
    case -4306:
        return_value_arg.description = "kCCOverflow";
        break;
    case -4307:
        return_value_arg.description = "kCCRNGFailure";
        break;
    }
    char return_value_value[200];
    snprintf(return_value_value, 200, "%d", (int)return_value);
    return_value_arg.value = return_value_value;
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_return(to_string(callID), return_value_arg);
        });
    }
    thread_infos->call_id_stack->pop_back();
    return return_value;
}


CCCryptorStatus ____CCCryptorFinal(CCCryptorRef cryptorRef, void * dataOut, size_t dataOutAvailable, size_t * dataOutMoved)
{
    thread_storage_t *thread_infos = get_thread_infos();
    call_id_t callID;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    callID = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(callID);
    vector<argument_t> args;
    argument_t cryptorRef_arg;
    cryptorRef_arg.type = "CCCryptorRef";
    char cryptorRef_value[200];
    snprintf(cryptorRef_value, 200, "%d", (int)cryptorRef);
    cryptorRef_arg.value = cryptorRef_value;
    args.push_back(cryptorRef_arg);

    argument_t dataOut_arg;
    dataOut_arg.type = "^void";
    char dataOut_value[200];
    snprintf(dataOut_value, 200, "0x%X", (register_t)dataOut);
    dataOut_arg.value = dataOut_value;
    args.push_back(dataOut_arg);

    argument_t dataOutAvailable_arg;
    dataOutAvailable_arg.type = "size_t";
    char dataOutAvailable_value[200];
    snprintf(dataOutAvailable_value, 200, "%d", (int)dataOutAvailable);
    dataOutAvailable_arg.value = dataOutAvailable_value;
    args.push_back(dataOutAvailable_arg);

    argument_t dataOutMoved_arg;
    dataOutMoved_arg.type = "^size_t";
    char dataOutMoved_value[200];
    snprintf(dataOutMoved_value, 200, "0x%X", (register_t)dataOutMoved);
    dataOutMoved_arg.value = dataOutMoved_value;
    args.push_back(dataOutMoved_arg);

    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_call(to_string(callID), to_string(caller_id), "CommonCrypto", "CCCryptorFinal", "0x0", args);
        });
    }
    CCCryptorStatus return_value =     original_CCCryptorFinal(cryptorRef, dataOut, dataOutAvailable, dataOutMoved);
    argument_t return_value_arg;
    return_value_arg.type = "CCCryptorStatus";
    switch (return_value) {
    case 0:
        return_value_arg.description = "kCCSuccess";
        break;
    case -4300:
        return_value_arg.description = "kCCParamError";
        break;
    case -4301:
        return_value_arg.description = "kCCBufferTooSmall";
        break;
    case -4302:
        return_value_arg.description = "kCCMemoryFailure";
        break;
    case -4303:
        return_value_arg.description = "kCCAlignmentError";
        break;
    case -4304:
        return_value_arg.description = "kCCDecodeError";
        break;
    case -4305:
        return_value_arg.description = "kCCUnimplemented";
        break;
    case -4306:
        return_value_arg.description = "kCCOverflow";
        break;
    case -4307:
        return_value_arg.description = "kCCRNGFailure";
        break;
    }
    char return_value_value[200];
    snprintf(return_value_value, 200, "%d", (int)return_value);
    return_value_arg.value = return_value_value;
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_return(to_string(callID), return_value_arg);
        });
    }
    thread_infos->call_id_stack->pop_back();
    return return_value;
}


CCCryptorStatus ____CCCryptorCreateFromData(CCOperation op, CCAlgorithm alg, CCOptions options, const void * key, size_t keyLength, const void * iv, const void * data, size_t dataLength, CCCryptorRef * cryptorRef, size_t * dataUsed)
{
    thread_storage_t *thread_infos = get_thread_infos();
    call_id_t callID;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    callID = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(callID);
    vector<argument_t> args;
    argument_t op_arg;
    op_arg.type = "CCOperation";
    switch (op) {
    case 0:
        op_arg.description = "kCCEncrypt";
        break;
    case 1:
        op_arg.description = "kCCDecrypt";
        break;
    }
    char op_value[200];
    snprintf(op_value, 200, "%d", (int)op);
    op_arg.value = op_value;
    args.push_back(op_arg);

    argument_t alg_arg;
    alg_arg.type = "CCAlgorithm";
    switch (alg) {
    case 0:
        alg_arg.description = "kCCAlgorithmAES128";
        break;
    case 1:
        alg_arg.description = "kCCAlgorithmDES";
        break;
    case 2:
        alg_arg.description = "kCCAlgorithm3DES";
        break;
    case 3:
        alg_arg.description = "kCCAlgorithmCAST";
        break;
    case 4:
        alg_arg.description = "kCCAlgorithmRC4";
        break;
    case 5:
        alg_arg.description = "kCCAlgorithmRC2";
        break;
    case 6:
        alg_arg.description = "kCCAlgorithmBlowfish";
        break;
    }
    char alg_value[200];
    snprintf(alg_value, 200, "%d", (int)alg);
    alg_arg.value = alg_value;
    args.push_back(alg_arg);

    argument_t options_arg;
    options_arg.type = "CCOptions";
    char options_value[200];
    snprintf(options_value, 200, "%d", (int)options);
    options_arg.value = options_value;
    args.push_back(options_arg);

    argument_t key_arg;
    key_arg.type = "^void";
    char key_value[200];
    snprintf(key_value, 200, "0x%X", (register_t)key);
    key_arg.value = key_value;
    args.push_back(key_arg);

    argument_t keyLength_arg;
    keyLength_arg.type = "size_t";
    char keyLength_value[200];
    snprintf(keyLength_value, 200, "%d", (int)keyLength);
    keyLength_arg.value = keyLength_value;
    args.push_back(keyLength_arg);

    argument_t iv_arg;
    iv_arg.type = "^void";
    char iv_value[200];
    snprintf(iv_value, 200, "0x%X", (register_t)iv);
    iv_arg.value = iv_value;
    args.push_back(iv_arg);

    argument_t data_arg;
    data_arg.type = "^void";
    char data_value[200];
    snprintf(data_value, 200, "0x%X", (register_t)data);
    data_arg.value = data_value;
    args.push_back(data_arg);

    argument_t dataLength_arg;
    dataLength_arg.type = "size_t";
    char dataLength_value[200];
    snprintf(dataLength_value, 200, "%d", (int)dataLength);
    dataLength_arg.value = dataLength_value;
    args.push_back(dataLength_arg);

    argument_t cryptorRef_arg;
    cryptorRef_arg.type = "^CCCryptorRef";
    char cryptorRef_value[200];
    snprintf(cryptorRef_value, 200, "0x%X", (register_t)cryptorRef);
    cryptorRef_arg.value = cryptorRef_value;
    args.push_back(cryptorRef_arg);

    argument_t dataUsed_arg;
    dataUsed_arg.type = "^size_t";
    char dataUsed_value[200];
    snprintf(dataUsed_value, 200, "0x%X", (register_t)dataUsed);
    dataUsed_arg.value = dataUsed_value;
    args.push_back(dataUsed_arg);

    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_call(to_string(callID), to_string(caller_id), "CommonCrypto", "CCCryptorCreateFromData", "0x0", args);
        });
    }
    CCCryptorStatus return_value =     original_CCCryptorCreateFromData(op, alg, options, key, keyLength, iv, data, dataLength, cryptorRef, dataUsed);
    argument_t return_value_arg;
    return_value_arg.type = "CCCryptorStatus";
    switch (return_value) {
    case 0:
        return_value_arg.description = "kCCSuccess";
        break;
    case -4300:
        return_value_arg.description = "kCCParamError";
        break;
    case -4301:
        return_value_arg.description = "kCCBufferTooSmall";
        break;
    case -4302:
        return_value_arg.description = "kCCMemoryFailure";
        break;
    case -4303:
        return_value_arg.description = "kCCAlignmentError";
        break;
    case -4304:
        return_value_arg.description = "kCCDecodeError";
        break;
    case -4305:
        return_value_arg.description = "kCCUnimplemented";
        break;
    case -4306:
        return_value_arg.description = "kCCOverflow";
        break;
    case -4307:
        return_value_arg.description = "kCCRNGFailure";
        break;
    }
    char return_value_value[200];
    snprintf(return_value_value, 200, "%d", (int)return_value);
    return_value_arg.value = return_value_value;
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_return(to_string(callID), return_value_arg);
        });
    }
    thread_infos->call_id_stack->pop_back();
    return return_value;
}


CCCryptorStatus ____CCCryptorCreateWithMode(CCOperation op, CCMode mode, CCAlgorithm alg, CCPadding padding, const void * iv, const void * key, size_t keyLength, const void * tweak, size_t tweakLength, int numRounds, CCModeOptions options, CCCryptorRef * cryptorRef)
{
    thread_storage_t *thread_infos = get_thread_infos();
    call_id_t callID;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    callID = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(callID);
    vector<argument_t> args;
    argument_t op_arg;
    op_arg.type = "CCOperation";
    switch (op) {
    case 0:
        op_arg.description = "kCCEncrypt";
        break;
    case 1:
        op_arg.description = "kCCDecrypt";
        break;
    }
    char op_value[200];
    snprintf(op_value, 200, "%d", (int)op);
    op_arg.value = op_value;
    args.push_back(op_arg);

    argument_t mode_arg;
    mode_arg.type = "CCMode";
    char mode_value[200];
    snprintf(mode_value, 200, "%d", (int)mode);
    mode_arg.value = mode_value;
    args.push_back(mode_arg);

    argument_t alg_arg;
    alg_arg.type = "CCAlgorithm";
    switch (alg) {
    case 0:
        alg_arg.description = "kCCAlgorithmAES128";
        break;
    case 1:
        alg_arg.description = "kCCAlgorithmDES";
        break;
    case 2:
        alg_arg.description = "kCCAlgorithm3DES";
        break;
    case 3:
        alg_arg.description = "kCCAlgorithmCAST";
        break;
    case 4:
        alg_arg.description = "kCCAlgorithmRC4";
        break;
    case 5:
        alg_arg.description = "kCCAlgorithmRC2";
        break;
    case 6:
        alg_arg.description = "kCCAlgorithmBlowfish";
        break;
    }
    char alg_value[200];
    snprintf(alg_value, 200, "%d", (int)alg);
    alg_arg.value = alg_value;
    args.push_back(alg_arg);

    argument_t padding_arg;
    padding_arg.type = "CCPadding";
    char padding_value[200];
    snprintf(padding_value, 200, "%d", (int)padding);
    padding_arg.value = padding_value;
    args.push_back(padding_arg);

    argument_t iv_arg;
    iv_arg.type = "^void";
    char iv_value[200];
    snprintf(iv_value, 200, "0x%X", (register_t)iv);
    iv_arg.value = iv_value;
    args.push_back(iv_arg);

    argument_t key_arg;
    key_arg.type = "^void";
    char key_value[200];
    snprintf(key_value, 200, "0x%X", (register_t)key);
    key_arg.value = key_value;
    args.push_back(key_arg);

    argument_t keyLength_arg;
    keyLength_arg.type = "size_t";
    char keyLength_value[200];
    snprintf(keyLength_value, 200, "%d", (int)keyLength);
    keyLength_arg.value = keyLength_value;
    args.push_back(keyLength_arg);

    argument_t tweak_arg;
    tweak_arg.type = "^void";
    char tweak_value[200];
    snprintf(tweak_value, 200, "0x%X", (register_t)tweak);
    tweak_arg.value = tweak_value;
    args.push_back(tweak_arg);

    argument_t tweakLength_arg;
    tweakLength_arg.type = "size_t";
    char tweakLength_value[200];
    snprintf(tweakLength_value, 200, "%d", (int)tweakLength);
    tweakLength_arg.value = tweakLength_value;
    args.push_back(tweakLength_arg);

    argument_t numRounds_arg;
    numRounds_arg.type = "i";
    char numRounds_value[200];
    snprintf(numRounds_value, 200, "%d", (int)numRounds);
    numRounds_arg.value = numRounds_value;
    args.push_back(numRounds_arg);

    argument_t options_arg;
    options_arg.type = "CCModeOptions";
    switch (options) {
    case 1:
        options_arg.description = "kCCModeOptionCTR_LE";
        break;
    case 2:
        options_arg.description = "kCCModeOptionCTR_BE";
        break;
    }
    char options_value[200];
    snprintf(options_value, 200, "%d", (int)options);
    options_arg.value = options_value;
    args.push_back(options_arg);

    argument_t cryptorRef_arg;
    cryptorRef_arg.type = "^CCCryptorRef";
    char cryptorRef_value[200];
    snprintf(cryptorRef_value, 200, "0x%X", (register_t)cryptorRef);
    cryptorRef_arg.value = cryptorRef_value;
    args.push_back(cryptorRef_arg);

    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_call(to_string(callID), to_string(caller_id), "CommonCrypto", "CCCryptorCreateWithMode", "0x0", args);
        });
    }
    CCCryptorStatus return_value =     original_CCCryptorCreateWithMode(op, mode, alg, padding, iv, key, keyLength, tweak, tweakLength, numRounds, options, cryptorRef);
    argument_t return_value_arg;
    return_value_arg.type = "CCCryptorStatus";
    switch (return_value) {
    case 0:
        return_value_arg.description = "kCCSuccess";
        break;
    case -4300:
        return_value_arg.description = "kCCParamError";
        break;
    case -4301:
        return_value_arg.description = "kCCBufferTooSmall";
        break;
    case -4302:
        return_value_arg.description = "kCCMemoryFailure";
        break;
    case -4303:
        return_value_arg.description = "kCCAlignmentError";
        break;
    case -4304:
        return_value_arg.description = "kCCDecodeError";
        break;
    case -4305:
        return_value_arg.description = "kCCUnimplemented";
        break;
    case -4306:
        return_value_arg.description = "kCCOverflow";
        break;
    case -4307:
        return_value_arg.description = "kCCRNGFailure";
        break;
    }
    char return_value_value[200];
    snprintf(return_value_value, 200, "%d", (int)return_value);
    return_value_arg.value = return_value_value;
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_return(to_string(callID), return_value_arg);
        });
    }
    thread_infos->call_id_stack->pop_back();
    return return_value;
}


CCCryptorStatus ____CCCryptorRelease(CCCryptorRef cryptorRef)
{
    thread_storage_t *thread_infos = get_thread_infos();
    call_id_t callID;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    callID = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(callID);
    vector<argument_t> args;
    argument_t cryptorRef_arg;
    cryptorRef_arg.type = "CCCryptorRef";
    char cryptorRef_value[200];
    snprintf(cryptorRef_value, 200, "%d", (int)cryptorRef);
    cryptorRef_arg.value = cryptorRef_value;
    args.push_back(cryptorRef_arg);

    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_call(to_string(callID), to_string(caller_id), "CommonCrypto", "CCCryptorRelease", "0x0", args);
        });
    }
    CCCryptorStatus return_value =     original_CCCryptorRelease(cryptorRef);
    argument_t return_value_arg;
    return_value_arg.type = "CCCryptorStatus";
    switch (return_value) {
    case 0:
        return_value_arg.description = "kCCSuccess";
        break;
    case -4300:
        return_value_arg.description = "kCCParamError";
        break;
    case -4301:
        return_value_arg.description = "kCCBufferTooSmall";
        break;
    case -4302:
        return_value_arg.description = "kCCMemoryFailure";
        break;
    case -4303:
        return_value_arg.description = "kCCAlignmentError";
        break;
    case -4304:
        return_value_arg.description = "kCCDecodeError";
        break;
    case -4305:
        return_value_arg.description = "kCCUnimplemented";
        break;
    case -4306:
        return_value_arg.description = "kCCOverflow";
        break;
    case -4307:
        return_value_arg.description = "kCCRNGFailure";
        break;
    }
    char return_value_value[200];
    snprintf(return_value_value, 200, "%d", (int)return_value);
    return_value_arg.value = return_value_value;
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_return(to_string(callID), return_value_arg);
        });
    }
    thread_infos->call_id_stack->pop_back();
    return return_value;
}


CCCryptorStatus ____CCCrypt(CCOperation op, CCAlgorithm alg, CCOptions options, const void * key, size_t keyLength, const void * iv, const void * dataIn, size_t dataInLength, void * dataOut, size_t dataOutAvailable, size_t * dataOutMoved)
{
    thread_storage_t *thread_infos = get_thread_infos();
    call_id_t callID;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    callID = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(callID);
    vector<argument_t> args;
    argument_t op_arg;
    op_arg.type = "CCOperation";
    switch (op) {
    case 0:
        op_arg.description = "kCCEncrypt";
        break;
    case 1:
        op_arg.description = "kCCDecrypt";
        break;
    }
    char op_value[200];
    snprintf(op_value, 200, "%d", (int)op);
    op_arg.value = op_value;
    args.push_back(op_arg);

    argument_t alg_arg;
    alg_arg.type = "CCAlgorithm";
    switch (alg) {
    case 0:
        alg_arg.description = "kCCAlgorithmAES128";
        break;
    case 1:
        alg_arg.description = "kCCAlgorithmDES";
        break;
    case 2:
        alg_arg.description = "kCCAlgorithm3DES";
        break;
    case 3:
        alg_arg.description = "kCCAlgorithmCAST";
        break;
    case 4:
        alg_arg.description = "kCCAlgorithmRC4";
        break;
    case 5:
        alg_arg.description = "kCCAlgorithmRC2";
        break;
    case 6:
        alg_arg.description = "kCCAlgorithmBlowfish";
        break;
    }
    char alg_value[200];
    snprintf(alg_value, 200, "%d", (int)alg);
    alg_arg.value = alg_value;
    args.push_back(alg_arg);

    argument_t options_arg;
    options_arg.type = "CCOptions";
    char options_value[200];
    snprintf(options_value, 200, "%d", (int)options);
    options_arg.value = options_value;
    args.push_back(options_arg);

    argument_t key_arg;
    key_arg.type = "^void";
    char key_value[200];
    snprintf(key_value, 200, "0x%X", (register_t)key);
    key_arg.value = key_value;
    args.push_back(key_arg);

    argument_t keyLength_arg;
    keyLength_arg.type = "size_t";
    char keyLength_value[200];
    snprintf(keyLength_value, 200, "%d", (int)keyLength);
    keyLength_arg.value = keyLength_value;
    args.push_back(keyLength_arg);

    argument_t iv_arg;
    iv_arg.type = "^void";
    char iv_value[200];
    snprintf(iv_value, 200, "0x%X", (register_t)iv);
    iv_arg.value = iv_value;
    args.push_back(iv_arg);

    argument_t dataIn_arg;
    dataIn_arg.type = "^void";
    char dataIn_value[200];
    snprintf(dataIn_value, 200, "0x%X", (register_t)dataIn);
    dataIn_arg.value = dataIn_value;
    args.push_back(dataIn_arg);

    argument_t dataInLength_arg;
    dataInLength_arg.type = "size_t";
    char dataInLength_value[200];
    snprintf(dataInLength_value, 200, "%d", (int)dataInLength);
    dataInLength_arg.value = dataInLength_value;
    args.push_back(dataInLength_arg);

    argument_t dataOut_arg;
    dataOut_arg.type = "^void";
    char dataOut_value[200];
    snprintf(dataOut_value, 200, "0x%X", (register_t)dataOut);
    dataOut_arg.value = dataOut_value;
    args.push_back(dataOut_arg);

    argument_t dataOutAvailable_arg;
    dataOutAvailable_arg.type = "size_t";
    char dataOutAvailable_value[200];
    snprintf(dataOutAvailable_value, 200, "%d", (int)dataOutAvailable);
    dataOutAvailable_arg.value = dataOutAvailable_value;
    args.push_back(dataOutAvailable_arg);

    argument_t dataOutMoved_arg;
    dataOutMoved_arg.type = "^size_t";
    char dataOutMoved_value[200];
    snprintf(dataOutMoved_value, 200, "0x%X", (register_t)dataOutMoved);
    dataOutMoved_arg.value = dataOutMoved_value;
    args.push_back(dataOutMoved_arg);

    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_call(to_string(callID), to_string(caller_id), "CommonCrypto", "CCCrypt", "0x0", args);
        });
    }
    CCCryptorStatus return_value =     original_CCCrypt(op, alg, options, key, keyLength, iv, dataIn, dataInLength, dataOut, dataOutAvailable, dataOutMoved);
    argument_t return_value_arg;
    return_value_arg.type = "CCCryptorStatus";
    switch (return_value) {
    case 0:
        return_value_arg.description = "kCCSuccess";
        break;
    case -4300:
        return_value_arg.description = "kCCParamError";
        break;
    case -4301:
        return_value_arg.description = "kCCBufferTooSmall";
        break;
    case -4302:
        return_value_arg.description = "kCCMemoryFailure";
        break;
    case -4303:
        return_value_arg.description = "kCCAlignmentError";
        break;
    case -4304:
        return_value_arg.description = "kCCDecodeError";
        break;
    case -4305:
        return_value_arg.description = "kCCUnimplemented";
        break;
    case -4306:
        return_value_arg.description = "kCCOverflow";
        break;
    case -4307:
        return_value_arg.description = "kCCRNGFailure";
        break;
    }
    char return_value_value[200];
    snprintf(return_value_value, 200, "%d", (int)return_value);
    return_value_arg.value = return_value_value;
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_return(to_string(callID), return_value_arg);
        });
    }
    thread_infos->call_id_stack->pop_back();
    return return_value;
}


CCCryptorStatus ____CCCryptorUpdate(CCCryptorRef cryptorRef, const void * dataIn, size_t dataInLength, void * dataOut, size_t dataOutAvailable, size_t * dataOutMoved)
{
    thread_storage_t *thread_infos = get_thread_infos();
    call_id_t callID;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    callID = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(callID);
    vector<argument_t> args;
    argument_t cryptorRef_arg;
    cryptorRef_arg.type = "CCCryptorRef";
    char cryptorRef_value[200];
    snprintf(cryptorRef_value, 200, "%d", (int)cryptorRef);
    cryptorRef_arg.value = cryptorRef_value;
    args.push_back(cryptorRef_arg);

    argument_t dataIn_arg;
    dataIn_arg.type = "^void";
    char dataIn_value[200];
    snprintf(dataIn_value, 200, "0x%X", (register_t)dataIn);
    dataIn_arg.value = dataIn_value;
    args.push_back(dataIn_arg);

    argument_t dataInLength_arg;
    dataInLength_arg.type = "size_t";
    char dataInLength_value[200];
    snprintf(dataInLength_value, 200, "%d", (int)dataInLength);
    dataInLength_arg.value = dataInLength_value;
    args.push_back(dataInLength_arg);

    argument_t dataOut_arg;
    dataOut_arg.type = "^void";
    char dataOut_value[200];
    snprintf(dataOut_value, 200, "0x%X", (register_t)dataOut);
    dataOut_arg.value = dataOut_value;
    args.push_back(dataOut_arg);

    argument_t dataOutAvailable_arg;
    dataOutAvailable_arg.type = "size_t";
    char dataOutAvailable_value[200];
    snprintf(dataOutAvailable_value, 200, "%d", (int)dataOutAvailable);
    dataOutAvailable_arg.value = dataOutAvailable_value;
    args.push_back(dataOutAvailable_arg);

    argument_t dataOutMoved_arg;
    dataOutMoved_arg.type = "^size_t";
    char dataOutMoved_value[200];
    snprintf(dataOutMoved_value, 200, "0x%X", (register_t)dataOutMoved);
    dataOutMoved_arg.value = dataOutMoved_value;
    args.push_back(dataOutMoved_arg);

    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_call(to_string(callID), to_string(caller_id), "CommonCrypto", "CCCryptorUpdate", "0x0", args);
        });
    }
    CCCryptorStatus return_value =     original_CCCryptorUpdate(cryptorRef, dataIn, dataInLength, dataOut, dataOutAvailable, dataOutMoved);
    argument_t return_value_arg;
    return_value_arg.type = "CCCryptorStatus";
    switch (return_value) {
    case 0:
        return_value_arg.description = "kCCSuccess";
        break;
    case -4300:
        return_value_arg.description = "kCCParamError";
        break;
    case -4301:
        return_value_arg.description = "kCCBufferTooSmall";
        break;
    case -4302:
        return_value_arg.description = "kCCMemoryFailure";
        break;
    case -4303:
        return_value_arg.description = "kCCAlignmentError";
        break;
    case -4304:
        return_value_arg.description = "kCCDecodeError";
        break;
    case -4305:
        return_value_arg.description = "kCCUnimplemented";
        break;
    case -4306:
        return_value_arg.description = "kCCOverflow";
        break;
    case -4307:
        return_value_arg.description = "kCCRNGFailure";
        break;
    }
    char return_value_value[200];
    snprintf(return_value_value, 200, "%d", (int)return_value);
    return_value_arg.value = return_value_value;
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_return(to_string(callID), return_value_arg);
        });
    }
    thread_infos->call_id_stack->pop_back();
    return return_value;
}


uint ____CCCalibratePBKDF(CCPBKDFAlgorithm algorithm, size_t passwordLen, size_t saltLen, CCPseudoRandomAlgorithm prf, size_t derivedKeyLen, uint32_t msec)
{
    thread_storage_t *thread_infos = get_thread_infos();
    call_id_t callID;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    callID = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(callID);
    vector<argument_t> args;
    argument_t algorithm_arg;
    algorithm_arg.type = "CCPBKDFAlgorithm";
    switch (algorithm) {
    case 2:
        algorithm_arg.description = "kCCPBKDF2";
        break;
    }
    char algorithm_value[200];
    snprintf(algorithm_value, 200, "%d", (int)algorithm);
    algorithm_arg.value = algorithm_value;
    args.push_back(algorithm_arg);

    argument_t passwordLen_arg;
    passwordLen_arg.type = "size_t";
    char passwordLen_value[200];
    snprintf(passwordLen_value, 200, "%d", (int)passwordLen);
    passwordLen_arg.value = passwordLen_value;
    args.push_back(passwordLen_arg);

    argument_t saltLen_arg;
    saltLen_arg.type = "size_t";
    char saltLen_value[200];
    snprintf(saltLen_value, 200, "%d", (int)saltLen);
    saltLen_arg.value = saltLen_value;
    args.push_back(saltLen_arg);

    argument_t prf_arg;
    prf_arg.type = "CCPseudoRandomAlgorithm";
    switch (prf) {
    case 1:
        prf_arg.description = "kCCPRFHmacAlgSHA1";
        break;
    case 2:
        prf_arg.description = "kCCPRFHmacAlgSHA224";
        break;
    case 3:
        prf_arg.description = "kCCPRFHmacAlgSHA256";
        break;
    case 4:
        prf_arg.description = "kCCPRFHmacAlgSHA384";
        break;
    case 5:
        prf_arg.description = "kCCPRFHmacAlgSHA512";
        break;
    }
    char prf_value[200];
    snprintf(prf_value, 200, "%d", (int)prf);
    prf_arg.value = prf_value;
    args.push_back(prf_arg);

    argument_t derivedKeyLen_arg;
    derivedKeyLen_arg.type = "size_t";
    char derivedKeyLen_value[200];
    snprintf(derivedKeyLen_value, 200, "%d", (int)derivedKeyLen);
    derivedKeyLen_arg.value = derivedKeyLen_value;
    args.push_back(derivedKeyLen_arg);

    argument_t msec_arg;
    msec_arg.type = "uint32_t";
    char msec_value[200];
    snprintf(msec_value, 200, "%d", (int)msec);
    msec_arg.value = msec_value;
    args.push_back(msec_arg);

    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_call(to_string(callID), to_string(caller_id), "CommonCrypto", "CCCalibratePBKDF", "0x0", args);
        });
    }
    uint return_value =     original_CCCalibratePBKDF(algorithm, passwordLen, saltLen, prf, derivedKeyLen, msec);
    argument_t return_value_arg;
    return_value_arg.type = "uint";
    char return_value_value[200];
    snprintf(return_value_value, 200, "%d", (int)return_value);
    return_value_arg.value = return_value_value;
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_return(to_string(callID), return_value_arg);
        });
    }
    thread_infos->call_id_stack->pop_back();
    return return_value;
}


int ____CCKeyDerivationPBKDF(CCPBKDFAlgorithm algorithm, const char * password, size_t passwordLen, const uint8_t * salt, size_t saltLen, CCPseudoRandomAlgorithm prf, uint rounds, uint8_t * derivedKey, size_t derivedKeyLen)
{
    thread_storage_t *thread_infos = get_thread_infos();
    call_id_t callID;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    callID = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(callID);
    vector<argument_t> args;
    argument_t algorithm_arg;
    algorithm_arg.type = "CCPBKDFAlgorithm";
    switch (algorithm) {
    case 2:
        algorithm_arg.description = "kCCPBKDF2";
        break;
    }
    char algorithm_value[200];
    snprintf(algorithm_value, 200, "%d", (int)algorithm);
    algorithm_arg.value = algorithm_value;
    args.push_back(algorithm_arg);

    argument_t password_arg;
    password_arg.type = "^char";
    char password_value[200];
    snprintf(password_value, 200, "0x%X", (register_t)password);
    password_arg.value = password_value;
    args.push_back(password_arg);

    argument_t passwordLen_arg;
    passwordLen_arg.type = "size_t";
    char passwordLen_value[200];
    snprintf(passwordLen_value, 200, "%d", (int)passwordLen);
    passwordLen_arg.value = passwordLen_value;
    args.push_back(passwordLen_arg);

    argument_t salt_arg;
    salt_arg.type = "^uint8_t";
    char salt_value[200];
    snprintf(salt_value, 200, "0x%X", (register_t)salt);
    salt_arg.value = salt_value;
    args.push_back(salt_arg);

    argument_t saltLen_arg;
    saltLen_arg.type = "size_t";
    char saltLen_value[200];
    snprintf(saltLen_value, 200, "%d", (int)saltLen);
    saltLen_arg.value = saltLen_value;
    args.push_back(saltLen_arg);

    argument_t prf_arg;
    prf_arg.type = "CCPseudoRandomAlgorithm";
    switch (prf) {
    case 1:
        prf_arg.description = "kCCPRFHmacAlgSHA1";
        break;
    case 2:
        prf_arg.description = "kCCPRFHmacAlgSHA224";
        break;
    case 3:
        prf_arg.description = "kCCPRFHmacAlgSHA256";
        break;
    case 4:
        prf_arg.description = "kCCPRFHmacAlgSHA384";
        break;
    case 5:
        prf_arg.description = "kCCPRFHmacAlgSHA512";
        break;
    }
    char prf_value[200];
    snprintf(prf_value, 200, "%d", (int)prf);
    prf_arg.value = prf_value;
    args.push_back(prf_arg);

    argument_t rounds_arg;
    rounds_arg.type = "uint";
    char rounds_value[200];
    snprintf(rounds_value, 200, "%d", (int)rounds);
    rounds_arg.value = rounds_value;
    args.push_back(rounds_arg);

    argument_t derivedKey_arg;
    derivedKey_arg.type = "^uint8_t";
    char derivedKey_value[200];
    snprintf(derivedKey_value, 200, "0x%X", (register_t)derivedKey);
    derivedKey_arg.value = derivedKey_value;
    args.push_back(derivedKey_arg);

    argument_t derivedKeyLen_arg;
    derivedKeyLen_arg.type = "size_t";
    char derivedKeyLen_value[200];
    snprintf(derivedKeyLen_value, 200, "%d", (int)derivedKeyLen);
    derivedKeyLen_arg.value = derivedKeyLen_value;
    args.push_back(derivedKeyLen_arg);

    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_call(to_string(callID), to_string(caller_id), "CommonCrypto", "CCKeyDerivationPBKDF", "0x0", args);
        });
    }
    int return_value =     original_CCKeyDerivationPBKDF(algorithm, password, passwordLen, salt, saltLen, prf, rounds, derivedKey, derivedKeyLen);
    argument_t return_value_arg;
    return_value_arg.type = "int";
    char return_value_value[200];
    snprintf(return_value_value, 200, "%d", (int)return_value);
    return_value_arg.value = return_value_value;
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_return(to_string(callID), return_value_arg);
        });
    }
    thread_infos->call_id_stack->pop_back();
    return return_value;
}


CCRNGStatus ____CCRandomGenerateBytes(void * bytes, size_t count)
{
    thread_storage_t *thread_infos = get_thread_infos();
    call_id_t callID;
    pthread_mutex_lock(&counter_mutex);
    ++counter;
    callID = counter;
    pthread_mutex_unlock(&counter_mutex);
    call_id_t caller_id = 0;
    if (thread_infos->call_id_stack->size()) {
        caller_id = thread_infos->call_id_stack->back();
    }
    thread_infos->call_id_stack->push_back(callID);
    vector<argument_t> args;
    argument_t bytes_arg;
    bytes_arg.type = "^void";
    char bytes_value[200];
    snprintf(bytes_value, 200, "0x%X", (register_t)bytes);
    bytes_arg.value = bytes_value;
    args.push_back(bytes_arg);

    argument_t count_arg;
    count_arg.type = "size_t";
    char count_value[200];
    snprintf(count_value, 200, "%d", (int)count);
    count_arg.value = count_value;
    args.push_back(count_arg);

    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_call(to_string(callID), to_string(caller_id), "CommonCrypto", "CCRandomGenerateBytes", "0x0", args);
        });
    }
    CCRNGStatus return_value =     original_CCRandomGenerateBytes(bytes, count);
    argument_t return_value_arg;
    return_value_arg.type = "CCRNGStatus";
    switch (return_value) {
    case 0:
        return_value_arg.description = "kCCSuccess";
        break;
    case -4300:
        return_value_arg.description = "kCCParamError";
        break;
    case -4301:
        return_value_arg.description = "kCCBufferTooSmall";
        break;
    case -4302:
        return_value_arg.description = "kCCMemoryFailure";
        break;
    case -4303:
        return_value_arg.description = "kCCAlignmentError";
        break;
    case -4304:
        return_value_arg.description = "kCCDecodeError";
        break;
    case -4305:
        return_value_arg.description = "kCCUnimplemented";
        break;
    case -4306:
        return_value_arg.description = "kCCOverflow";
        break;
    case -4307:
        return_value_arg.description = "kCCRNGFailure";
        break;
    }
    char return_value_value[200];
    snprintf(return_value_value, 200, "%d", (int)return_value);
    return_value_arg.value = return_value_value;
    if (enabled_) {
        dispatch_async(db_queue, ^ {
            insert_return(to_string(callID), return_value_arg);
        });
    }
    thread_infos->call_id_stack->pop_back();
    return return_value;
}


