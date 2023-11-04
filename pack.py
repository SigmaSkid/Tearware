import os
import shutil
import datetime

if os.path.exists("release"):
    shutil.rmtree("release")
    print("Deleting release directory.")

print("Recreating release directory.")
os.mkdir("release")

print("Copying base files.")
shutil.copy("main.lua", "release/main.lua")
shutil.copy("LICENSE", "release/LICENSE")
shutil.copy("id.txt", "release/id.txt")
shutil.copy("info.txt", "release/info.txt")
shutil.copy("preview.jpg", "release/preview.jpg")

print("Creating source directory.")
os.mkdir("release/source")

print("Copying project files.")

# define the function, (it copies a tree btw.)
def copytree(src, dst, symlinks=False, ignore=None):
    if not os.path.exists(dst):
        os.makedirs(dst)
        shutil.copystat(src, dst)
    lst = os.listdir(src)
    if ignore:
        excl = ignore(src, lst)
        lst = [x for x in lst if x not in excl]
    for item in lst:
        s = os.path.join(src, item)
        d = os.path.join(dst, item)
        if symlinks and os.path.islink(s):
            if os.path.lexists(d):
                os.remove(d)
            os.symlink(os.readlink(s), d)
            try:
                st = os.lstat(s)
                mode = stat.S_IMODE(st.st_mode)
                os.lchmod(d, mode)
            except:
                pass # lchmod not available
        elif os.path.isdir(s):
            copytree(s, d, symlinks, ignore)
        else:
            shutil.copy2(s, d)

# call the function ;)
copytree("source", "release/source")

# remove junk code basically
print("Removing comments, unnecessary spaces, and newlines from .lua files.")

# array
lua_files = []

# populate array with all of the source files
for root, dirs, files in os.walk("release/source"):
    for file in files:
        if file.endswith(".lua"):
            lua_files.append(os.path.join(root, file))

# do the optimizations
# 04.11.2023, we save around 34KB ~ 36KB
for file in lua_files:
    print(file)
    with open(file, "r") as f:
        lines = f.readlines()
    with open(file, "w") as f:
        for line in lines:
            line = line.split('--', 1)[0].lstrip().rstrip()  # remove comments and trailing spaces
            if line:
                f.write(line + "\n")
    print("")

print("Updating local.lua")

# Location of local.lua file
file = "release/source/utils/local.lua"

# Get the current date
date = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# Check if file exists
if os.path.isfile(file):
    # Replace the line
    with open(file, "r") as f:
        lines = f.readlines()
    with open(file, "w") as f:
        for line in lines:
            if 'fProjectName = "Tearware Github Preview"' in line:
                line = line.replace('fProjectName = "Tearware Github Preview"', 'fProjectName = "Tearware"')
            f.write(line)
    print("Line replaced successfully in", file)
else:
    print("Error:", file, "not found")

print("Adding 'Packaged on", date, "to main.lua")
file = "release/main.lua"
if os.path.isfile(file):
    with open(file, "a") as f:
        f.write("\n-- Packaged on " + date + "\n")
    print("Line added successfully in", file)
else:
    print("Error:", file, "not found")

print("Finished.")
