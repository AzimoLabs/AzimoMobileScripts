#!/bin/sh

# The script will try to find usage of a given argument in all frameworks located in a current folder recursively.

SEARCH_VALUE=$1

if [ $# -eq 0 ]; then
      echo "No arguments supplied. You have to provide one argument."
      exit 1
fi

LIST_OF_FOUNDED_FRAMEWORKS=""
for FRAMEWORK_PATH in $(find . -iname "*.framework"); do
  FRAMEWORK_NAME=$(basename $FRAMEWORK_PATH .framework)
  RESULT=$(nm $FRAMEWORK_PATH/$FRAMEWORK_NAME | grep $SEARCH_VALUE)
  if [ ! -z "$RESULT" -a "$RESULT" != " " ]; then
        echo $FRAMEWORK_PATH/$FRAMEWORK_NAME
        echo $RESULT
        LIST_OF_FOUNDED_FRAMEWORKS="${LIST_OF_FOUNDED_FRAMEWORKS}\n${FRAMEWORK_NAME}"
  fi
done

echo ""
echo "$LIST_OF_FOUNDED_FRAMEWORKS"
