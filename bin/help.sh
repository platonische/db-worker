#!/bin/bash

SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )
cd $SCRIPTPATH
ROOTPATH=$( cd "$SCRIPTPATH/.." ; pwd -P )
cd $ROOTPATH

source ./src/loader.sh

echo "Add help info"