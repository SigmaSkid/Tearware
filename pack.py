#!/usr/bin/env python3
import os
import re
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

# remove comments to reduce size.
# 11.05.2026, we save around ~41.53 KB
total_bytes_saved = 0
for file in lua_files:
    print(file)

    original_size = os.path.getsize(file)

    with open(file, "r", encoding="utf-8") as f:
        content = f.read()

    # Remove multiline comments --[[ ... ]]
    content = re.sub(r'--\[\[.*?\]\]', '', content, flags=re.DOTALL)

    # Split into lines again to handle single-line comments
    lines = content.splitlines()
    new_lines = []
    for line in lines:
        # Remove single-line comments
        line = re.sub(r'--.*$', '', line)
        line = line.strip()
        if line:  # skip empty lines
            new_lines.append(line)
    
    # Write back
    with open(file, "w", encoding="utf-8") as f:
        f.write("\n".join(new_lines))

    new_size = os.path.getsize(file)
    saved = original_size - new_size
    total_bytes_saved += saved

print(f"Total memory savings: {total_bytes_saved/1024:.2f} KB\n")

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
