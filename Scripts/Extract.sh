#!/bin/bash
#system="back"
IMG="system.img"
OUT="$DIR/system"
TMP="$DIR/tmp_out"

#Crear directorios
if [ -d "$OUT" ];then
	echo "La carpeta system existe"
else
	mkdir -p "$OUT"
fi;

if [ -d "$TMP" ];then
	echo "La carpeta tmp_out existe"
else
	mkdir -p "$TMP"
fi;

#Montar y extraer system
if [ -f "$IMG" ];then
	echo "Montando $IMG"
	fuse.erofs "$IMG" "$TMP" &>/dev/null
else
	echo "$IMG no esta"
fi;

if [ -d "$OUT" ];then
	if [ -d "$TMP" ];then
		echo "copiando archivos de $TMP"
		cp -a --preserve=all $TMP/* "$OUT"
	else
		echo "$TMP no existe"
	fi;
else
	echo "$OUT no existe"
fi;

