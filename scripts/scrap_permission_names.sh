#!/bin/bash

OUTPUT_PATH="outputs/"
OUTPUT_FILE="${OUTPUT_PATH}permission_names"

BASE_URL="https://developer.android.com/reference/android/Manifest.permission"
MANIFEST_PAGE_FILE="manifest.html"

wget $BASE_URL -q -O $MANIFEST_PAGE_FILE

cat $MANIFEST_PAGE_FILE | grep -o \
    -e "\"android.*permission.*\"" \
    -e "\"com.android.*.permission.*\"" | grep -v "android.Manifest.permission" > ${OUTPUT_FILE}

rm $MANIFEST_PAGE_FILE