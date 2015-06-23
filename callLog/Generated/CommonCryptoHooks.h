#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonRandom.h>

//------------------------------------------------------------
//			CommonCryptor.h
//------------------------------------------------------------

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


CCCryptorStatus CCCryptorCreate(
    CCOperation op,
    CCAlgorithm alg,
    CCOptions options,
    const void *key,
    size_t keyLength,
    const void *iv,
    CCCryptorRef *cryptorRef)
{
	data(key, keyLength);
  if (iv && alg == kCCAlgorithmAES) data(iv, 16);
  if (iv && alg != kCCAlgorithmAES) data(iv, 8);
  out(std(cryptorRef));
}

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
    size_t *dataUsed)
{
	data(key, keyLength);
  data(data, dataLength);
  if (iv && alg == kCCAlgorithmAES) data(iv, 16);
  if (iv && alg != kCCAlgorithmAES) data(iv, 8);
  out(std(cryptorRef));
}

CCCryptorStatus CCCryptorRelease(
    CCCryptorRef cryptorRef);

CCCryptorStatus CCCryptorUpdate(
    CCCryptorRef cryptorRef,
    const void *dataIn,
    size_t dataInLength,
    void *dataOut,
    size_t dataOutAvailable,
    size_t *dataOutMoved)
{
  data(dataIn, dataInLength);
  out(data(dataOut, *dataOutMoved));
}

CCCryptorStatus CCCryptorFinal(
    CCCryptorRef cryptorRef,
    void *dataOut,
    size_t dataOutAvailable,
    size_t *dataOutMoved)
{
  out(data(dataOut, *dataOutMoved));
}

size_t CCCryptorGetOutputLength(
    CCCryptorRef cryptorRef,
    size_t inputLength,
    bool final);

CCCryptorStatus CCCryptorReset(
    CCCryptorRef cryptorRef,
    const void *iv);

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
    CCCryptorRef	*cryptorRef)
{
  data(key, keyLength);
  if (tweak != NULL) data(tweak, tweakLength);
  if (iv && alg == kCCAlgorithmAES) data(iv, 16);
  if (iv && alg != kCCAlgorithmAES) data(iv, 8);
  out(std(cryptorRef));
}

//------------------------------------------------------------
//			CommonKeyDerivation.h
//------------------------------------------------------------


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

int
CCKeyDerivationPBKDF( CCPBKDFAlgorithm algorithm, const char *password, size_t passwordLen,
                      const uint8_t *salt, size_t saltLen,
                      CCPseudoRandomAlgorithm prf, uint rounds,
                      uint8_t *derivedKey, size_t derivedKeyLen)
{
  data(password, passwordLen);
	data(salt, saltLen);
  out(data(derivedKey, derivedKeyLen));
}

uint
CCCalibratePBKDF(CCPBKDFAlgorithm algorithm, size_t passwordLen, size_t saltLen,
                 CCPseudoRandomAlgorithm prf, size_t derivedKeyLen, uint32_t msec);

//------------------------------------------------------------
//			CommonRandom.h
//------------------------------------------------------------

CCRNGStatus CCRandomGenerateBytes(void *bytes, size_t count)
{
	out(data(bytes, count));
}

//------------------------------------------------------------
//			CommonDigest.h
//------------------------------------------------------------

int CC_MD2_Init(CC_MD2_CTX *c)
{
  out(std(c));
}

int CC_MD2_Update(CC_MD2_CTX *c, const void *data, CC_LONG len)
{
  data(data, len);
}

int CC_MD2_Final(unsigned char *md, CC_MD2_CTX *c)
{
  out(data(md, CC_MD2_DIGEST_LENGTH));
}

unsigned char *CC_MD2(const void *data, CC_LONG len, unsigned char *md)
{
  data(data, len);
  out(data(md, CC_MD2_DIGEST_LENGTH));
}

int CC_MD4_Init(CC_MD4_CTX *c)
{
  out(std(c));
}

int CC_MD4_Update(CC_MD4_CTX *c, const void *data, CC_LONG len)
{
  data(data, len);
}

int CC_MD4_Final(unsigned char *md, CC_MD4_CTX *c)
{
  out(data(md, CC_MD4_DIGEST_LENGTH));
}

unsigned char *CC_MD4(const void *data, CC_LONG len, unsigned char *md)
{
  data(data, len);
  out(data(md, CC_MD4_DIGEST_LENGTH));
}

int CC_MD5_Init(CC_MD5_CTX *c)
{
  out(std(c));
}

int CC_MD5_Update(CC_MD5_CTX *c, const void *data, CC_LONG len)
{
  data(data, len);
}

int CC_MD5_Final(unsigned char *md, CC_MD5_CTX *c)
{
  out(data(md, CC_MD5_DIGEST_LENGTH));
}

unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)
{
  out(data(md, CC_MD5_DIGEST_LENGTH));
}

int CC_SHA1_Init(CC_SHA1_CTX *c)
{
  out(std(c));
}

int CC_SHA1_Update(CC_SHA1_CTX *c, const void *data, CC_LONG len)
{
  data(data, len);
}

int CC_SHA1_Final(unsigned char *md, CC_SHA1_CTX *c)
{
  out(data(md, CC_SHA1_DIGEST_LENGTH));
}

unsigned char *CC_SHA1(const void *data, CC_LONG len, unsigned char *md)
{
  data(data, len);
  out(data(md, CC_SHA1_DIGEST_LENGTH));
}

int CC_SHA224_Init(CC_SHA256_CTX *c)
{
  out(std(c));
}

int CC_SHA224_Update(CC_SHA256_CTX *c, const void *data, CC_LONG len)
{
  data(data, len);
}

int CC_SHA224_Final(unsigned char *md, CC_SHA256_CTX *c)
{
  out(data(md, CC_SHA224_DIGEST_LENGTH));
}

unsigned char *CC_SHA224(const void *data, CC_LONG len, unsigned char *md)
{
  data(data, len);
  out(data(md, CC_SHA224_DIGEST_LENGTH));
}

int CC_SHA256_Init(CC_SHA256_CTX *c)
{
  out(std(c));
}

int CC_SHA256_Update(CC_SHA256_CTX *c, const void *data, CC_LONG len)
{
  data(data, len);
}

int CC_SHA256_Final(unsigned char *md, CC_SHA256_CTX *c)
{
  out(data(md, CC_SHA256_DIGEST_LENGTH));
}

unsigned char *CC_SHA256(const void *data, CC_LONG len, unsigned char *md)
{
	data(data, len);
  out(data(md, CC_SHA256_DIGEST_LENGTH));
}

int CC_SHA384_Init(CC_SHA512_CTX *c)
{
  out(std(c));
}

int CC_SHA384_Update(CC_SHA512_CTX *c, const void *data, CC_LONG len)
{
  data(data, len);
}

int CC_SHA384_Final(unsigned char *md, CC_SHA512_CTX *c)
{
  out(data(md, CC_SHA384_DIGEST_LENGTH));
}

unsigned char *CC_SHA384(const void *data, CC_LONG len, unsigned char *md)
{
  data(data, len);
  out(data(md, CC_SHA384_DIGEST_LENGTH));
}

int CC_SHA512_Init(CC_SHA512_CTX *c)
{
  out(std(c));
}

int CC_SHA512_Update(CC_SHA512_CTX *c, const void *data, CC_LONG len)
{
  data(data, len);
}

int CC_SHA512_Final(unsigned char *md, CC_SHA512_CTX *c)
{
  out(data(md, CC_SHA512_DIGEST_LENGTH));
}

unsigned char *CC_SHA512(const void *data, CC_LONG len, unsigned char *md)
{
  data(data, len);
	out(data(md, CC_SHA512_DIGEST_LENGTH));
}
