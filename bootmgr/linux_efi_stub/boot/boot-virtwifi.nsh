@echo -off
echo Booting @BOOTMGR_ANDROID_DISTRIBUTION_NAME@
echo Options: VirtWifi
kernel.efi initrd=combined-ramdisk.img @STRIPPED_BOARD_KERNEL_CMDLINE@ androidboot.wifi_impl=virt_wifi
