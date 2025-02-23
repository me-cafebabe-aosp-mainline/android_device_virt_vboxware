#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Boot manager
TARGET_BOOT_MANAGER := grub

# Inherit from common
include device/virt/virt-common/BoardConfigVirtCommon.mk

USES_DEVICE_VIRT_VBOXWARE := true

# Arch
TARGET_CPU_ABI := x86_64
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := sandybridge

# Boot manager
TARGET_EFI_BOOT_SCRIPTS := $(wildcard $(DEVICE_PATH)/bootmgr/linux_efi_stub/boot/*.nsh)
TARGET_EFI_INSTALL_SCRIPTS := $(wildcard $(DEVICE_PATH)/bootmgr/linux_efi_stub/install/*.nsh)
TARGET_GRUB_BOOT_CONFIGS += $(DEVICE_PATH)/bootmgr/grub/grub-boot.cfg
TARGET_GRUB_INSTALL_CONFIGS += $(DEVICE_PATH)/bootmgr/grub/grub-install.cfg

# Bootconfig
TARGET_BOOTCONFIG_FILES += $(DEVICE_PATH)/configs/misc/bootconfig.txt

# Fstab
ifeq ($(AB_OTA_UPDATER),true)
$(call soong_config_set,VBOXWARE_FSTAB,PARTITION_SCHEME,ab)
else
$(call soong_config_set,VBOXWARE_FSTAB,PARTITION_SCHEME,a)
endif

# Graphics (Mesa)
BOARD_MESA3D_USES_MESON_BUILD := true
BOARD_MESA3D_GALLIUM_DRIVERS := svga

# GRUB
TARGET_GRUB_ARCH := x86_64-efi

# Kernel
BOARD_KERNEL_CMDLINE += \
    8250.nr_uarts=1

BOARD_KERNEL_IMAGE_NAME := bzImage

ifneq ($(wildcard $(TARGET_KERNEL_SOURCE)/Makefile),)
TARGET_KERNEL_ARCH := x86
TARGET_KERNEL_CONFIG += \
    lineageos/vboxware.config
else ifneq ($(wildcard $(TARGET_PREBUILT_KERNEL_DIR)/kernel),)
BOARD_VENDOR_KERNEL_MODULES := \
    $(wildcard $(TARGET_PREBUILT_KERNEL_DIR)/*.ko)
endif

# Recovery
TARGET_RECOVERY_FSTAB_GENRULE := gen_fstab_vboxware
TARGET_RECOVERY_PIXEL_FORMAT := BGRX_8888

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += \
    $(DEVICE_PATH)/sepolicy/vendor

ifeq ($(AB_OTA_UPDATER),true)
BOARD_VENDOR_SEPOLICY_DIRS += \
    $(DEVICE_PATH)/sepolicy/vendor/ab
else
BOARD_VENDOR_SEPOLICY_DIRS += \
    $(DEVICE_PATH)/sepolicy/vendor/a
endif

# VINTF
ODM_MANIFEST_SKUS := display_drm display_fb
ODM_MANIFEST_DISPLAY_DRM_FILES := $(DEVICE_PATH)/configs/vintf/manifest_sku_display_drm.xml
ODM_MANIFEST_DISPLAY_FB_FILES := $(DEVICE_PATH)/configs/vintf/manifest_sku_display_fb.xml
