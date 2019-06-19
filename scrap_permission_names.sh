#!/bin/bash

BASE_URL="https://developer.android.com/reference/android/Manifest.permission"
MANIFEST_PAGE_FILE="manifest.html"
OUTPUT_PATH="outputs/"

wget $BASE_URL -q -O $MANIFEST_PAGE_FILE

cat $MANIFEST_PAGE_FILE | grep -o \
    -e "\"android.*permission.*\"" \
    -e "\"com.android.*.permission.*\"" | grep -v "android.Manifest.permission" | tr -d '"' > ${OUTPUT_PATH}permission_names

rm $MANIFEST_PAGE_FILE