
# DECOMPILE SYSTEM EROFS
## Small work to decompile system.img in erofs format on linux

### How use?
• Clone the repository with: ```git clone https://github.com/TOMMYGUISEPE/Build-_LICH.git```.

• Copy the system.img you want to decompile into the root directory of the cloned repository.

• Use ```source Decompile.sh``` (You may need to run "sudo su" before).

• After that you will get the system/ folder with the extracted system.img files, which you can modify.

• Please note that you will also need to modify the file_context and fs_configs files located in the sources/ folder depending on the changes in system/

• You can then compile the system.img using ```source Recompile.sh```  (If you need to change the size of the system.img you can do so by modifying the Recompile.sh from this line: mkfs.erofs -zlz4hc,9 -b 4096 -T 1640995200)

• The recompiled system.img will be found in Build/

### Note

This is an experimental work since I'm not good at programming/writing code.

If you want to contribute to the code, let me know via telegram: @TOM_a54
