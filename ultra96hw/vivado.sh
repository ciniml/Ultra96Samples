#!/bin/bash

if grep -q Microsoft /proc/version; then
    if [ "$VIVADO_ROOT" == "" ]; then
        echo "VIVADO_ROOT must be set"
        exit 1
    fi
    cmd.exe /C $VIVADO_ROOT/bin/vivado.bat $*
else
    vivado $*
fi
