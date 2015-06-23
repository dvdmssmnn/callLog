java -jar CodeGenerator.jar --in=callLog/Generated/DevHooks.h --out=callLog/Generated/Dev.mm --package=Dev;
java -jar CodeGenerator.jar --in=callLog/Generated/CFURLRequestHooks.h --out=callLog/Generated/CFURLRequest.mm --package=CFURLRequest;
java -jar CodeGenerator.jar --in=callLog/Generated/CFNetworkHooks.h --out=callLog/Generated/CFNetwork.mm --package=CFNetwork;
java -jar CodeGenerator.jar --in=callLog/Generated/CFURLHooks.h --out=callLog/Generated/CFURL.mm --package=CFURL;
java -jar CodeGenerator.jar --in=callLog/Generated/CommonCryptoHooks.h --out=callLog/Generated/CommonCrypto.mm --package=CommonCrypto;
java -jar CodeGenerator.jar --in=callLog/Generated/CFStreamHooks.h --out=callLog/Generated/CFStream.mm --package=CFStream;
java -jar CodeGenerator.jar --in=callLog/Generated/SecurityHooks.h --out=callLog/Generated/Security.mm --package=Security;
