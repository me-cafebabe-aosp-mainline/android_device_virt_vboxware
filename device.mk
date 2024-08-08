#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from common
$(call inherit-product, device/virt/virt-common/virt-common.mk)

# Graphics (Mesa)
#ifneq ($(wildcard external/mesa/android/Android.mk),)
ifeq (0,1)
PRODUCT_PACKAGES += \
    libEGL_mesa \
    libGLESv1_CM_mesa \
    libGLESv2_mesa \
    libgallium_dri \
    libglapi

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.graphics.mesa.is_upstream=true
else
PRODUCT_PACKAGES += \
    libGLES_mesa

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.graphics.mesa.is_upstream=false

PRODUCT_SOONG_NAMESPACES += \
    external/mesa3d
endif

# Graphics (Composer)
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.1-service \
    hwcomposer.drm

PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.hwcomposer=drm

# Graphics (Gralloc)
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.mapper@2.0-impl-2.1 \
    gralloc.drm

PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.gralloc=drm

# Init
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/init.vboxware.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.vboxware.rc

PRODUCT_PACKAGES += \
    fstab.vboxware

# Input
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/.emptyfile:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/QEMU_QEMU_USB_Tablet.kl \
    $(LOCAL_PATH)/config/.emptyfile:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/QEMU_Virtio_Tablet.kl

# Kernel
TARGET_PREBUILT_KERNEL_USE ?= 6.1
TARGET_PREBUILT_KERNEL_DIR := device/virt/kernel-vboxware/$(TARGET_PREBUILT_KERNEL_USE)
TARGET_KERNEL_SOURCE := kernel/virt/virtio
ifneq ($(wildcard $(TARGET_KERNEL_SOURCE)/Makefile),)
    $(warning Using source built kernel)
else ifneq ($(wildcard $(TARGET_PREBUILT_KERNEL_DIR)/kernel),)
    PRODUCT_COPY_FILES += $(TARGET_PREBUILT_KERNEL_DIR)/kernel:kernel
    $(warning Using prebuilt kernel from $(TARGET_PREBUILT_KERNEL_DIR)/kernel)
endif

# Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/init.recovery.vboxware.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.vboxware.rc

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Vendor ramdisk
PRODUCT_PACKAGES += \
    fstab.vboxware.vendor_ramdisk

# Vendor service manager
PRODUCT_PACKAGES += \
    vndservicemanager
