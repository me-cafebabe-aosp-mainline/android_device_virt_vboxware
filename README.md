# Android common device tree for VirtualBox and VMware

The device tree is currently WIP, Not suitable for normal use.

```
#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#
```

# TODO
- Enforce SELinux on all targets

# Mandatory virtual machine configuration

| Item | Value | Description |
| ---- | ----- | ----------- |
| Firmware (If available) | UEFI (Without secure boot) | Would not add support for BIOS. |
| RAM | At least 1024 MB | At least 2048 MB is preferred. Strongly recommended to add `androidboot.low_perf=1` to kernel cmdline if it's below than 2048 MB. |
