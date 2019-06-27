#!/bin/bash

OUTPUT_PATH="outputs/"
PERMISSION_NAME_FILE="${OUTPUT_PATH}permission_names"
OUTPUT_FILE="${OUTPUT_PATH}permission_manifest"

# See README Caveats section
declare -a comment_permissions
comment_permissions=( "android.permission.PROCESS_OUTGOING_CALLS" \
    "android.permission.READ_CALL_LOG" \
    "android.permission.READ_SMS" \
    "android.permission.RECEIVE_MMS" \
    "android.permission.RECEIVE_SMS" \
    "android.permission.RECEIVE_WAP_PUSH" \
    "android.permission.SEND_SMS" \
    "android.permission.WRITE_CALL_LOG" )

# echo ${comment_permissions[@]}

> $OUTPUT_FILE  # truncate

while read PERMISSION; do
    if [[ ! " ${comment_permissions[@]} " =~ " ${PERMISSION} " ]]; then
        echo "<uses-permission android:name=${PERMISSION}/>" >> $OUTPUT_FILE
    else
        echo "<!--uses-permission android:name=${PERMISSION}/-->" >> $OUTPUT_FILE
        echo "Permission ${PERMISSION} commented out. See Caveats in README"
    fi
done < $PERMISSION_NAME_FILE

