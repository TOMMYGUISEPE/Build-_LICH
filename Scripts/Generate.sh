#!/bin/bash

img="system.img"
PARTITION="system"
PREFIX="sudo"

echo "Generating fs_config/file_context for $img"
            [ -f "file_context-$PARTITION" ] && rm "file_context-$PARTITION"
            [ -f "fs_config-$PARTITION" ] && rm "fs_config-$PARTITION"
            while read -r i; do
                {
                    echo -n "$i "
                    $PREFIX getfattr -n security.selinux --only-values -h "$i"
                    echo ""
                } >> "file_context-$PARTITION"

                case "$i" in
                    *"run-as" | *"simpleperf_app_runner")
                        CAPABILITIES="0xc0"
                        ;;
                    *)
                        CAPABILITIES="0x0"
                        ;;
                esac
                $PREFIX stat -c "%n %u %g %a capabilities=$CAPABILITIES" "$i" >> "fs_config-$PARTITION"
            done <<< "$($PREFIX find "tmp_out")"
            if [ "$PARTITION" = "system" ]; then
                sed -i "s/tmp_out /\/ /g" "file_context-$PARTITION" \
                    && sed -i "s/tmp_out\//\//g" "file_context-$PARTITION"
                sed -i "s/tmp_out / /g" "fs_config-$PARTITION" \
                    && sed -i "s/tmp_out\///g" "fs_config-$PARTITION"
            else
                sed -i "s/tmp_out/\/$PARTITION/g" "file_context-$PARTITION"
                sed -i "s/tmp_out / /g" "fs_config-$PARTITION" \
                    && sed -i "s/tmp_out/$PARTITION/g" "fs_config-$PARTITION"
            fi
            sed -i "s/\x0//g" "file_context-$PARTITION" \
                && sed -i 's/\./\\./g' "file_context-$PARTITION" \
                && sed -i 's/\+/\\+/g' "file_context-$PARTITION" \
                && sed -i 's/\[/\\[/g' "file_context-$PARTITION"
                
mv file_context-system fs_config-system "$RECSOURCE"
umount "$TMP"
echo "Done"
