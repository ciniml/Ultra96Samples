#!/bin/bash
cmd=`basename $0 .sh`
if grep -q Microsoft /proc/version; then
    if [ "$VIVADO_ROOT" == "" ]; then
        echo "VIVADO_ROOT must be set"
        exit 1
    fi
    cmd.exe /C $VIVADO_ROOT/bin/${cmd}.bat $*
else
    ${cmd} $*
fi
