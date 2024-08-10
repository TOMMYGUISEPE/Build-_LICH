#!/bin/bash

echo " "
echo "Wellcome to Build LICH ROM"
echo " "
echo "Preparing directories"
echo " "
#Variables de los directorios
DIR="$(git rev-parse --show-toplevel)"
TOOLS="$DIR/Tools"
SCRIPTS="$P_DIR/Scripts"
BUILD="$P_DIR/Build"
RECSOURCE="$P_DIR/Resources"
echo "Main variables ready"
echo " "
#Prueba
cd "$P_DIR"
cd "$TOOLS"
#cd $SCRIPTS && touch hello.sh
#cd $BUILD && touch hello.sh
#cd $RECSOURCE && touch hello.sh

#End Build
echo "Build Finish"
