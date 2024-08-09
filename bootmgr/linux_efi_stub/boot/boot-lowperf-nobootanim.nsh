@echo -off
echo Booting @BOOTMGR_ANDROID_DISTRIBUTION_NAME@
echo Options: Enable low performance optimizations, Disable boot animation
kernel.efi initrd=combined-ramdisk.img @STRIPPED_BOARD_KERNEL_CMDLINE@ androidboot.low_perf=1 androidboot.nobootanim=1
