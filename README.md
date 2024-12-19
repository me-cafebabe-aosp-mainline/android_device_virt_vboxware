# Android common device tree for VirtualBox and VMware

```
#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#
```

# Required patches for AOSP

| Repository | Commit message | Link |
| ---------- | -------------- | ---- |
| bootable/recovery | minui: drm: Add support for DRM_FORMAT_XRGB8888 | [LineageOS Gerrit](https://review.lineageos.org/c/LineageOS/android_bootable_recovery/+/403877) |
| hardware/interfaces | audio: aidl: default: primary: Read LatencyMs from prop | [LineageOS Gerrit](https://review.lineageos.org/c/LineageOS/android_hardware_interfaces/+/409764) |
