#!/bin/bash
DIR="$(git rev-parse --show-toplevel)"
TOOLS="$DIR/tools"
SCRIPTS="$DIR/Scripts"
BUILD="$DIR/Build"
RECSOURCE="$DIR/Resources"

PATH="$TOOLS:$PATH"

PARTITION="system"
SOURCE_DIR="system" # La carpeta con los archivos
FILE_CONTEXTS="$RECSOURCE/file_context-system" # Archivo de contextos de archivos
FS_CONFIG="$RECSOURCE/fs_config-system" # Archivo de configuración del sistema de archivos
OUTPUT_IMG="system.img.raw" # Nombre del archivo de salida

echo "Recompilando"

if [ -d "$BUILD" ];then
	[[ $PARTITION == "system" ]] && MOUNT_POINT="/" || MOUNT_POINT="/$PARTITION"

mkfs.erofs -zlz4hc,9 -b 4096 -T 1640995200 \
    --mount-point="$MOUNT_POINT" --file-contexts="$FILE_CONTEXTS" --fs-config="$FS_CONFIG" \
    "$SOURCE_DIR/../$OUTPUT_IMG" "$SOURCE_DIR"
else
	mkdir -p "$BUILD"
	[[ $PARTITION == "system" ]] && MOUNT_POINT="/" || MOUNT_POINT="/$PARTITION"

mkfs.erofs -zlz4hc,9 -b 4096 -T 1640995200 \
    --mount-point="$MOUNT_POINT" --file-contexts="$FILE_CONTEXTS" --fs-config="$FS_CONFIG" \
    "$SOURCE_DIR/../$OUTPUT_IMG" "$SOURCE_DIR"
fi;

if [ -f system.img.raw ]; then
	mv system.img.raw "$BUILD"
	cd "$BUILD"
	mv system.img.raw system.img
else
	echo "system.img.raw no existe"
fi;

cd "$DIR"
echo "Archivo recompilado ;D"
