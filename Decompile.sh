#!/bin/bash

echo " "
echo "Wellcome to Build LICH ROM"
echo " "
echo "Preparing directories"
echo " "
#Variables de los directorios
DIR="$(git rev-parse --show-toplevel)"
TOOLS="$DIR/tools"
SCRIPTS="$DIR/Scripts"
BUILD="$DIR/Build"
RECSOURCE="$DIR/Resources"

PATH="$TOOLS:$PATH"

echo "Main variables ready"
echo " "

#Crear directorios faltantes
if [ -d Build/ ];then
	rm -rf "$DIR/Build/*"
else
	mkdir -p Build
fi;

if [ -d Resources/ ];then
	rm -rf "$DIR/Resources/*"
else
	mkdir -p Resources
fi;

#Extraer rom

run_cmd() {
    local cmd="$1"
    echo "Ejecutando: $cmd"
    $cmd
}

run_cmd "source $SCRIPTS/Extract.sh"

#Generar fs_configs y file_contex

run_cmd() {
    local cmd="$1"
    echo "Ejecutando: $cmd"
    $cmd
}

run_cmd "source $SCRIPTS/Generate.sh"

#End Build
echo "Build Finish"
