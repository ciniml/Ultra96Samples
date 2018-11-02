#!/bin/bash

if grep -q Microsoft /proc/version; then
    if [ "$XSDK_ROOT" == "" ]; then
        echo "XSDK_ROOT must be set"
        exit 1
    fi
    cmd.exe /C $XSDK_ROOT/bin/bootgen.bat $*
else
    bootgen $*
fi
