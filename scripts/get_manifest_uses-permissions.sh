#!/bin/bash

OUTPUT_PATH="../outputs/"
PERMISSION_NAME_FILE="${OUTPUT_PATH}permission_names"
OUTPUT_FILE="${OUTPUT_PATH}permission_manifest"

> $OUTPUT_FILE  # truncate

while read PERMISSION; do
    echo "<uses-permission android:name=\"${PERMISSION}\"/>" >> $OUTPUT_FILE
done < $PERMISSION_NAME_FILE

