#!/bin/bash  

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

# thank you gpt-sama
echo "Updating local.lua"

# Location of local.lua file
file="release/source/local.lua"

# Get the current date
date=$(date)

# Check if file exists
if [ -f $file ]; then
    # Replace the line
    sed -i 's/fProjectName = "Tearware Github Preview"/fProjectName = "Tearware"/g' $file
    # Replace the line "-- obviously change it before uploading to workshop." with "Packaged on date"
    sed -i "s/-- obviously change it before uploading to workshop./-- Packaged on $date/g" $file
    echo "Line replaced and date added successfully in $file"
else
    echo "Error: $file not found"
fi

echo "Finished."