#callLog

callLog hooks the *objc_msgSend()* function and logs these calls to a SQLite database. Additionally to the *objc_msgSend()* function some (security sensitive) functions are hooked too:
* CommonCrypto
* Security
* CFNetwork


##Inject Library

Use the release version of the library for real apps, otherwise

###Requirements
* Only 32-bit iOS Devices are supported for now
* Decrypted IPA (use Clutch on jailbroken iDevice)
* Developer Certificate
* optool in your PATH environment variable (https://github.com/alexzielenski/optool)

###Run
####Inject the library into an arbitrary IPA file
    python inject.py -i "{IPA filename}" -c "{Certificate Name (in the keychain)}" [-o "{output filename}"]

Install the patched IPA using Xcode.

####Add the library through Xcode
1. Add argTrace.framework as embedded binary
2. Add CydiaSubstrate.framework as embedded binary
3. Run

##Execute

The library starts automatically after installing the app with the library injected.

###Configuration

The library starts an HTTP server that offers an interface to configure the library and download the logged data.

For configuration go to http://deviceIP:8080/terminal.html

####Blacklist/Whitelist
The parameters of whitelisted methods are always parsed and those of the blacklisted ones never.

    config option=whitelist class=CLASSNAME method=METHODNAME
    config option=blacklist class=CLASSNAME method=METHODNAME

Class or method have to be present (or both)

#####Bundle Whitelist

On start only the apps main bundle is tracked. Other bundles can be whitelisted similar to methods/classes

    config option=whitelist bundle=BUNDLE_ID

####Description length

    config option=max_description_length value=LENGTH

Sets the maximum length of data that is stored per value in an call. Default is 0 and this means nothing is truncated.


##Known Issues
###Jailbroken device needed for patched IPA
Currently there are some issues that prevent the library from running on jailed devices when injecting the library into an IPA file. However, if you add the library to a project in Xcode it runs on jailed devices too.

###Exceptions
In most cases exceptions do not cause any issues, but in some cases the application crashes. <br/>
The [NSObject methodSignatureForSelector:] method, which is used in the framework, throws an exception for some signatures and if this happens the method gets automatically blacklisted, but still the application *may* crash (the blacklisted method is blacklisted again at the next start and the app will not crash again for this particular method).

###Categories

Methods that are added via categories to existing classes are handled like methods of the class itself. This may cause some problems when a method is added to a class of a bundle that is not whitelisted (e.g. a method was added to *NSData*) because the parameters may not be completely parsed.

###Grand Central Dispatch

If you have something like:

    NSData *someData = [NSData data];
    dispatch_async(dispatch_get_main_queue(), ^{
      [someData bytes];
    });

In this case the call *[someData bytes]* will **not** be logged (if we have not whitelisted the bundle containing NSData) because callLog does not know yet from which bundle the call to *dispatch_async()* was made. 

###Malformed Database
The database downloaded via HTTP is malformed sometimes. It may work after downloading it a few times more or creating a dump of the malformed database and creating a new database from this dump.

    sqlite3 db.sqlite ".dump" > dump.sql && rm db.sqlite  && sqlite3 db.sqlite < dump.sql && rm dump.sql

###Constant strings
Constant strings passed to other bundles are not detected.

###Filesystem data
CoreData writes are not recognized yet as such and can't be used for analyzing.

For some *write()* calls to a filedescriptor we can't find the corresponding *open()* calls and therefore we only know that data gets written somewhere, but not exactly where. But for data written from the apps main bundle this seems to work fine.

###Network Connections
Network connections seem to work really slow (but don't cause any errors).
