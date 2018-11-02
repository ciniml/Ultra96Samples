#!/bin/bash
cat << EOT > $2
all:
{
    [destination_device = pl] $1
}
EOT
