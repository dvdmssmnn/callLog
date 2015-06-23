#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonRandom.h>

enum {
    kCCEncrypt = 0, 
    kCCDecrypt,     
};
typedef uint32_t CCOperation;

enum {
    kCCAlgorithmAES128 = 0,
    kCCAlgorithmAES = 0,
    kCCAlgorithmDES,
    kCCAlgorithm3DES,       
    kCCAlgorithmCAST,       
    kCCAlgorithmRC4,
    kCCAlgorithmRC2,   
    kCCAlgorithmBlowfish    
};
typedef uint32_t CCAlgorithm;

enum {
    kCCSuccess          = 0,
    kCCParamError       = -4300,
    kCCBufferTooSmall   = -4301,
    kCCMemoryFailure    = -4302,
    kCCAlignmentError   = -4303,
    kCCDecodeError      = -4304,
    kCCUnimplemented    = -4305,
    kCCOverflow         = -4306,
    kCCRNGFailure       = -4307,
};
typedef int32_t CCStatus;
typedef int32_t CCCryptorStatus;
typedef int32_t CCRNGStatus;

enum {
	kCCModeOptionCTR_LE	= 0x0001,
	kCCModeOptionCTR_BE = 0x0002 
};

typedef uint32_t CCModeOptions;

enum {
    kCCPBKDF2 = 2,
};


typedef uint32_t CCPBKDFAlgorithm;


enum {
    kCCPRFHmacAlgSHA1 = 1, 
    kCCPRFHmacAlgSHA224 = 2,
    kCCPRFHmacAlgSHA256 = 3,
    kCCPRFHmacAlgSHA384 = 4,
    kCCPRFHmacAlgSHA512 = 5,
};


typedef uint32_t CCPseudoRandomAlgorithm;


CCCryptorStatus CCCryptorCreate(
    CCOperation op,       
    CCAlgorithm alg,         
    CCOptions options,   
    const void *key,           
    size_t keyLength,   
    const void *iv,            
    CCCryptorRef *cryptorRef) ;
    
    CCCryptorStatus CCCryptorFinal(
    CCCryptorRef cryptorRef,
    void *dataOut,
    size_t dataOutAvailable,
    size_t *dataOutMoved);
    
CCCryptorStatus CCCryptorCreateFromData(
    CCOperation op,         
    CCAlgorithm alg,        
    CCOptions options,       
    const void *key,           
    size_t keyLength,   
    const void *iv,            
    const void *data,           
    size_t dataLength,         
    CCCryptorRef *cryptorRef,   
    size_t *dataUsed);
    
CCCryptorStatus CCCryptorCreateWithMode(
    CCOperation 	op,				
    CCMode			mode,
    CCAlgorithm		alg,
    CCPadding		padding,		
    const void 		*iv,		
    const void 		*key,			
    size_t 			keyLength,	
    const void 		*tweak,			
    size_t 			tweakLength,	
    int				numRounds,		
    CCModeOptions 	options,
    CCCryptorRef	*cryptorRef);
    
CCCryptorStatus CCCryptorRelease(
    CCCryptorRef cryptorRef);
    
CCCryptorStatus CCCrypt(
    CCOperation op,         
    CCAlgorithm alg,        
    CCOptions options,      
    const void *key,
    size_t keyLength,
    const void *iv,         
    const void *dataIn,     
    size_t dataInLength,
    void *dataOut,          
    size_t dataOutAvailable,
    size_t *dataOutMoved);
    
CCCryptorStatus CCCryptorUpdate(
    CCCryptorRef cryptorRef,
    const void *dataIn,
    size_t dataInLength,
    void *dataOut,        
    size_t dataOutAvailable,
    size_t *dataOutMoved) ;
    
    
uint
CCCalibratePBKDF(CCPBKDFAlgorithm algorithm, size_t passwordLen, size_t saltLen,
                 CCPseudoRandomAlgorithm prf, size_t derivedKeyLen, uint32_t msec);
                 
int 
CCKeyDerivationPBKDF( CCPBKDFAlgorithm algorithm, const char *password, size_t passwordLen,
                      const uint8_t *salt, size_t saltLen,
                      CCPseudoRandomAlgorithm prf, uint rounds, 
                      uint8_t *derivedKey, size_t derivedKeyLen);
                      
CCRNGStatus CCRandomGenerateBytes(void *bytes, size_t count);
                 