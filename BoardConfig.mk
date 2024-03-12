#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/android/shiba

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# 12.1 manifest requirements
TARGET_SUPPORTS_64_BIT_APPS := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    product \
    vendor_dlkm \
    system_ext \
    odm_dlkm \
    vendor \
    init_boot \
    vbmeta \
    system \
    boot
BOARD_USES_RECOVERY_AS_BOOT := false

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a76
TARGET_CPU_VARIANT_RUNTIME := cortex-a76


TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53


# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := shiba
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 420
TARGET_USES_VULKAN := true

# EMULATOR common modules
BOARD_EMULATOR_COMMON_MODULES := liblight

OVERRIDE_RS_DRIVER := libRSDriverArm.so
BOARD_EGL_CFG := device/google/zuma/conf/egl.cfg
#BOARD_USES_HGL := true
USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
BOARD_USES_EXYNOS5_COMMON_GRALLOC := true
BOARD_USES_EXYNOS_GRALLOC_VERSION := 4
#BOARD_USES_EXYNOS_GRALLOC_VERSION := $(DEVICE_USES_EXYNOS_GRALLOC_VERSION)
BOARD_USES_ALIGN_RESTRICTION := false
BOARD_USES_GRALLOC_ION_SYNC := true

# This should be the same value as USE_SWIFTSHADER in device.mk
BOARD_USES_SWIFTSHADER := false

# Kernel
BOARD_VENDOR_KERNEL_MODULES_LOAD_RAW := $(strip $(shell cat device/google/shiba/vendor_dlkm.modules.load))
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(foreach m,$(BOARD_VENDOR_KERNEL_MODULES_LOAD_RAW),$(notdir $(m)))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD_RAW := $(strip $(shell cat device/google/shiba/vendor_kernel_boot.modules.load))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(foreach m,$(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD_RAW),$(notdir $(m)))
BOOT_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD)
TARGET_KERNEL_EXT_MODULES := \
    aoc/usb \
    bms \
    display/samsung \
    edgetpu/janeiro/drivers/edgetpu \
    gpu/mali_kbase \
    gpu/mali_pixel \
    gxp/gs201 \
    lwis \
    power/reset \
    touch/common \
    touch/focaltech/ft3658 \
    touch/goodix \
    uwb/kernel \
    video/gchips \
    ../devices/google/shiba/display

BOARD_BOOTIMG_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x10000000
VENDOR_CMDLINE := exynos_drm.load_sequential=1 g2d.load_sequential=1 samsung_iommu_v9.load_sequential=1 swiotlb=noforce disable_dma32=on earlycon=exynos4210,0x10870000 console=ttySAC0,115200 androidboot.console=ttySAC0 printk.devkmsg=on cma_sysfs.experimental=Y cgroup_disable=memory rcupdate.rcu_expedited=1 rcu_nocbs=all swiotlb=1024 cgroup.memory=nokmem sysctl.kernel.sched_pelt_multiplier=4 kasan=off at24.write_timeout=100 log_buf_len=1024K bootconfig androidboot.selinux.permissive
# Kernel
BOARD_KERNEL_BASE        := 0x1000000
BOARD_KERNEL_PAGESIZE    := 2048
BOARD_KERNEL_OFFSET      := 0x00008000
BOARD_RAMDISK_OFFSET     := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_DTB_OFFSET         := 0x01f00000
BOARD_RAMDISK_USE_LZ4     := true
BOARD_PREBUILT_DTBOIMAGE := device/google/shiba/prebuilt/dtbo.img


TARGET_RECOVERY_PIXEL_FORMAT := ABGR_8888
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 165
TARGET_RECOVERY_UI_LIB := \
	librecovery_ui_pixel \
	libfstab

BOARD_PREBUILT_BOOTIMAGE := device/google/shiba/prebuilt/boot.img
TARGET_NO_KERNEL := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

TARGET_RECOVERY_WIPE := device/google/zuma/recovery.wipe
TARGET_RECOVERY_FSTAB := device/google/zuma/recovery.fstab
# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
BOARD_SUPER_PARTITION_SIZE := 9126805504 # TODO: Fix hardcoded value
BOARD_SUPER_PARTITION_GROUPS := android_dynamic_partitions
BOARD_ANDROID_DYNAMIC_PARTITIONS_PARTITION_LIST := system system system_dlkm system_ext product vendor vendor_dlkm
BOARD_ANDROID_DYNAMIC_PARTITIONS_SIZE := 9122611200 # TODO: Fix hardcoded value

# Platform
TARGET_BOARD_PLATFORM := zuma

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := ABGR_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

BOARD_USE_CODEC2_HIDL_1_2 := true
BOARD_USE_CSC_FILTER := false
BOARD_USE_DEC_SW_CSC := true
BOARD_USE_ENC_SW_CSC := true
BOARD_SUPPORT_MFC_ENC_RGB := true
BOARD_USE_BLOB_ALLOCATOR := false
BOARD_SUPPORT_MFC_ENC_BT2020 := true
BOARD_SUPPORT_FLEXIBLE_P010 := true

# Security patch level
VENDOR_SECURITY_PATCH := 2021-08-01

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# Enable chain partition for system.
BOARD_AVB_VBMETA_SYSTEM := system system_dlkm system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

ifneq ($(PRODUCT_BUILD_PVMFW_IMAGE),false)
BOARD_AVB_VBMETA_SYSTEM += pvmfw
endif

# Enable chained vbmeta for boot images
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA2048
BOARD_AVB_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 2

# Enable chained vbmeta for init_boot images
BOARD_AVB_INIT_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_INIT_BOOT_ALGORITHM := SHA256_RSA2048
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION := 4


# Hack: prevent anti rollback
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.1.0

# TWRP Configuration
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TW_MAX_BRIGHTNESS := 520
