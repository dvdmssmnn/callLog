import sys, getopt, os, subprocess

opts, args = getopt.getopt(sys.argv[1:], "i:c:b:f:o:", ["in=", "cert=", "bin=", "frameworks=", "out="])

infile = ""
cert = ""
binary = ""
framework_dir = ""
out = ""

for opt, arg in opts:
    if opt in ("-i", "--in"):
        infile = arg
        pass
    if opt in ("-c", "--cert"):
        cert = arg
        pass
    if opt in ("-f", "--frameworks"):
        framework_dir = arg;
        pass

    if opt in ("-o", "--out"):
        out = os.path.abspath(arg)
        pass


filename, extension = os.path.splitext(os.path.abspath(infile))

if out == "":
    out = filename + "_patched" + extension
if framework_dir == "":
    framework_dir = "InjectFrameworks/"

if extension != ".ipa":
    print ("wrong extension")
    sys.exit(0)

if not os.path.isfile(infile):
    print ("file " + os.path.abspath(infile) + " not found")
    sys.exit(0)

if not os.path.isdir(framework_dir):
    print("Framework dir not found")
    sys.exit(0)



FNULL = open(os.devnull, 'w')

print ("Injecting into: " + infile)

dirname = os.path.dirname(os.path.abspath(infile))
tmp_dir = dirname + "/tmp"

i = 0
while os.path.isdir(tmp_dir):
    tmp_dir = dirname + "/tmp" + str(i)
    i += 1
    pass

subprocess.call("rm " + out, shell=True, stdout=FNULL, stderr=FNULL)

result = subprocess.call("unzip \"" + os.path.abspath(infile) + "\" -d \"" + tmp_dir + "\"", shell=True, stdout=FNULL)
if result != 0:
    print("Could not unpack original IPA")
    exit()
subprocess.call("rm -rf \"" + tmp_dir + "\"/__MACOSX", shell=True, stdout=FNULL)

stdout = os.popen("find \"" + tmp_dir + "\" -iname \"*.app\"").read().rstrip().split("\n")[0]

app_dir = stdout

binary = app_dir + "/" + os.popen("plutil -convert xml1 -o - \"" + app_dir + "/Info.plist\" | grep -A1 Exec | tail -n1 | cut -f2  -d \">\" | cut -f1 -d \"<\"").read().rstrip().split("\n")[0]

if not os.path.isfile(binary):
    print("Can't find binary " + binary)
    sys.exit(0)

result = subprocess.call("mkdir \"" + app_dir + "/Frameworks\"", shell=True, stdout=FNULL)
if result != 0:
    print("Could not create frameworks folder")
    exit()


result = subprocess.call("cp -r \"" + framework_dir + "\" \"" + app_dir + "/Frameworks\"", shell=True, stdout=FNULL)
if result != 0:
    print("Could not copy frameworks")
    exit()

result = subprocess.call("codesign -fs \"" + cert + "\" \"" + app_dir + "/Frameworks/\"*.framework/ --deep --no-strict", shell=True)
if result != 0:
    print("Could not codesign frameworks")
    exit()


result = subprocess.call("optool install -c load -p @executable_path/Frameworks/callLog.framework/callLog -t \"" + binary + "\"", shell=True, stdout=FNULL)
if result != 0:
    print("Could not insert load command into binary")
    exit()

result = subprocess.call("chmod +x \"" + binary + "\"", shell=True, stdout=FNULL, stderr=FNULL)
if result != 0:
    print("Could not change permissions")
    exit()

result = subprocess.call("codesign -fs \"" + cert + "\" \"" + app_dir + "\" --no-strict", shell=True)
if result != 0:
    print("Could not codesign")
    exit()

result = subprocess.call("cd \"" + tmp_dir + "\" && zip -r \"" + out + "\" *", shell=True, stdout=FNULL)
if result != 0:
    print("Could not create new IPA")
    exit()

result = subprocess.call("rm -rf \"" + tmp_dir + "\"", shell=True)
if result != 0:
    print("Could not remove temporary folder")
    exit()
