#import <Security/Security.h>

//------------------------------------------------------------
//			SecRandom.h
//------------------------------------------------------------

int SecRandomCopyBytes(SecRandomRef rnd, size_t count, uint8_t *bytes)
{
  out(data(bytes, count));
}

//------------------------------------------------------------
//			SecKey.h
//------------------------------------------------------------

OSStatus SecKeyGeneratePair(CFDictionaryRef parameters_, SecKeyRef *publicKey, SecKeyRef *privateKey);

OSStatus SecKeyRawSign(SecKeyRef key, SecPadding padding, const uint8_t *dataToSign, size_t dataToSignLen, uint8_t *sig, size_t *sigLen)
{
  data(dataToSign, dataToSignLen);
  out(data(sig, *sigLen));
}

OSStatus SecKeyRawVerify(SecKeyRef key,	SecPadding padding, const uint8_t *signedData, size_t signedDataLen, const uint8_t *sig, size_t sigLen)
{
  data(signedData, signedDataLen);
  data(sig, sigLen);
}

OSStatus SecKeyEncrypt(SecKeyRef key, SecPadding padding,	const uint8_t	*plainText,	size_t plainTextLen, uint8_t *cipherText,	size_t *cipherTextLen)
{
  data(plainText, plainTextLen);
  out(data(cipherText, *cipherTextLen));
}

OSStatus SecKeyDecrypt(SecKeyRef key, SecPadding padding,const uint8_t *cipherText,	size_t cipherTextLen, uint8_t *plainText, size_t *plainTextLen)
{
  data(cipherText, cipherTextLen);
  out(data(plainText, *plainTextLen));
}

size_t SecKeyGetBlockSize(SecKeyRef key);

//------------------------------------------------------------
//			SecItem.h
//------------------------------------------------------------

OSStatus SecItemCopyMatching(CFDictionaryRef query, CFTypeRef *result);

OSStatus SecItemAdd(CFDictionaryRef attributes, CFTypeRef *result);

OSStatus SecItemUpdate(CFDictionaryRef query, CFDictionaryRef attributesToUpdate);

OSStatus SecItemDelete(CFDictionaryRef query);
