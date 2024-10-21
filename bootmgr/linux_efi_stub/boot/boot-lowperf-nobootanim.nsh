@echo -off
echo Booting @BOOTMGR_ANDROID_DISTRIBUTION_NAME@
echo Options: Enable low performance optimizations, Disable boot animation
kernel.efi %1 %2 %3 %4 %5 %6 %7 %8 %9 initrd=combined-ramdisk.img @STRIPPED_BOARD_KERNEL_CMDLINE@ @STRIPPED_BOARD_KERNEL_CMDLINE_BOOT@ androidboot.low_perf=1 androidboot.nobootanim=1
