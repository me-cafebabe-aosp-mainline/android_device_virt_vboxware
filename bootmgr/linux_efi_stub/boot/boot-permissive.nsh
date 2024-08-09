@echo -off
echo Booting @BOOTMGR_ANDROID_DISTRIBUTION_NAME@
echo Options: SELinux Permissive
kernel.efi %1 %2 %3 %4 %5 %6 %7 %8 %9 initrd=combined-ramdisk.img @STRIPPED_BOARD_KERNEL_CMDLINE@ androidboot.selinux=permissive
