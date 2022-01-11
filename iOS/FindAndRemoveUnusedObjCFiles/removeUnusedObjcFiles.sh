##!/usr/bin/env bash

# This script finds all .m files. Next, the script checks whether the file name
# appears in the "project.pbxproj" file.
# If not, the script finds the .h file and remove both.

# The temporary file to hold all files.
TMP_FILE_NAME=allObjcFiles.txt
# Find all files with .m extention and remove the path (only persist the file name with extension). Save it to the TMP_FILE_NAME
# We save just the name to later check if it appears in the .pbxproj file.
find . -type f -name "*.m" -exec basename {} \; > $TMP_FILE_NAME
# The link to the .pbxproj file
PBXRPOJ="$1"

while read p; do
  # Chec if the .pbxproj contains the file
  grep -q $p $PBXRPOJ;
  if [ $? -gt 0 ]; then
    # If .pbxproj does not contains the implementation file
    # find the implementation file - we need the absolute path to remove it.
    IMPLEMENTATOIN_FILE=$(find . -type f -name "$p")

    # Find the header file - the ${p/%".m"/".h"} replaces .m with .h
    HEADER_FILE=$(find . -type f -name ${p/%".m"/".h"})

    echo "removing: $IMPLEMENTATOIN_FILE"
    rm $IMPLEMENTATOIN_FILE
    echo "removing if exist: $HEADER_FILE"
    rm $HEADER_FILE
  fi
done < $TMP_FILE_NAME
rm $TMP_FILE_NAME
