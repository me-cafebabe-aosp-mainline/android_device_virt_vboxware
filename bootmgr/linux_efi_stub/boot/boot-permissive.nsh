@echo -off
echo Booting @BOOTMGR_ANDROID_DISTRIBUTION_NAME@
echo Options: SELinux Permissive
kernel.efi initrd=combined-ramdisk.img @STRIPPED_BOARD_KERNEL_CMDLINE@ androidboot.selinux=permissive
