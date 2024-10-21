@echo -off
echo Booting @BOOTMGR_ANDROID_DISTRIBUTION_NAME@ Recovery
echo Options: None
kernel.efi %1 %2 %3 %4 %5 %6 %7 %8 %9 initrd=combined-ramdisk-recovery.img @STRIPPED_BOARD_KERNEL_CMDLINE@ @STRIPPED_BOARD_KERNEL_CMDLINE_RECOVERY@
