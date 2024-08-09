@echo -off
echo Booting @BOOTMGR_ANDROID_DISTRIBUTION_NAME@ installer
echo Options: None
kernel.efi initrd=combined-ramdisk-recovery.img @STRIPPED_BOARD_KERNEL_CMDLINE@ androidboot.install=1
