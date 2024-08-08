#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Boot manager
TARGET_BOOT_MANAGER ?= grub

# Inherit from common
include device/virt/virt-common/BoardConfigVirtCommon.mk

USES_DEVICE_VIRT_VBOXWARE := true
DEVICE_PATH := device/virt/vboxware

# Arch
TARGET_CPU_ABI := x86_64
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := x86_64

# Boot manager
TARGET_GRUB_BOOT_CONFIG := $(DEVICE_PATH)/grub/grub-boot.cfg
TARGET_GRUB_INSTALL_CONFIG := $(DEVICE_PATH)/grub/grub-install.cfg
TARGET_REFIND_BOOT_CONFIG := $(DEVICE_PATH)/rEFInd/refind-boot.conf
TARGET_REFIND_INSTALL_CONFIG := $(DEVICE_PATH)/rEFInd/refind-install.conf

# Graphics (Mesa)
#ifneq ($(wildcard external/mesa/android/Android.mk),)
ifeq (0,1)
BUILD_BROKEN_INCORRECT_PARTITION_IMAGES := true
BOARD_MESA3D_BUILD_LIBGBM := true
BOARD_MESA3D_USES_MESON_BUILD := true
BOARD_MESA3D_GALLIUM_DRIVERS := svga
else
BOARD_GPU_DRIVERS := vmwgfx
endif

# GRUB
TARGET_GRUB_ARCH := x86_64-efi

# Kernel
BOARD_KERNEL_CMDLINE += \
    8250.nr_uarts=1 \
    androidboot.console=ttyS0 \
    androidboot.hardware=vboxware

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
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/config/fstab.vboxware
TARGET_RECOVERY_PIXEL_FORMAT := BGRX_8888

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += \
    $(DEVICE_PATH)/sepolicy/vendor

# VINTF
DEVICE_MANIFEST_FILE += \
    $(DEVICE_PATH)/config/manifest.xml
