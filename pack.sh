#!/bin/bash  
# thank you gpt-sama

if [ -d release ]; then
    rm -R release
    echo "Deleting release directory."
fi

echo "Recreating release directory."
mkdir release 

echo "Copying base files."
cp main.lua release/main.lua 
cp LICENSE release/LICENSE 
cp id.txt release/id.txt
cp info.txt release/info.txt 
cp preview.jpg release/preview.jpg 

echo "Creating source directory."
mkdir release/source

echo "Copying project files."
cp source/* release/source/

echo "Removing comments, unnecessary spaces, and newlines from .lua files."
for file in release/source/*.lua; do
    echo "$file"
    sed -i 's/^[ \t]*//' "$file" # remove spaces at the start of lines
    sed -n '/^\s*--/p' "$file" | awk '{print $0}' # echo comments
    sed -i '/^\s*--/d' "$file" # remove comments
    sed -i '/^$/d' "$file" # remove empty lines
    echo ""
done

echo "Updating local.lua"

# Location of local.lua file
file="release/source/local.lua"

# Get the current date
date=$(date)

# Check if file exists
if [ -f $file ]; then
    # Replace the line
    sed -i 's/fProjectName = "Tearware Github Preview"/fProjectName = "Tearware"/g' $file
    echo "Line replaced successfully in $file"
else
    echo "Error: $file not found"
fi

echo "Adding 'Packaged on $date' to main.lua"
file="release/main.lua"
if [ -f $file ]; then
    echo "" >> $file
    echo "-- Packaged on $date" >> $file
    echo "Line added successfully in $file"
else
    echo "Error: $file not found"
fi

echo "Finished."
