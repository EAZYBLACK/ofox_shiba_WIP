#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#


LOCAL_PATH := device/google/shiba
DEVICE_PATH := device/google/shiba

# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from virtual AB OTA config
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery.fstab:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/system/etc/recovery.fstab
PRODUCT_SHIPPING_API_LEVEL := 33
PRODUCT_TARGET_VNDK_VERSION := 33



PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    resize2fs.vendor_ramdisk \
    fsck.vendor_ramdisk \
    tune2fs.vendor_ramdisk

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-impl.recovery \
    android.hardware.boot@1.0-service \

PRODUCT_PACKAGES += \
    bootctrl.zuma \
    bootctrl.zuma.recovery

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.display.lbe.supported=1
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.set_idle_timer_ms=1500
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.ignore_hdr_camera_layers=true

# SecureElement
PRODUCT_PACKAGES += \
	android.hardware.secure_element@1.2-service-gto \
	android.hardware.secure_element@1.2-service-gto-ese2

# Vibrator
PRODUCT_VENDOR_PROPERTIES += \
	ro.vendor.vibrator.hal.supported_primitives=243 \
	ro.vendor.vibrator.hal.f0.comp.enabled=1 \
	ro.vendor.vibrator.hal.redc.comp.enabled=0 \
	persist.vendor.vibrator.hal.context.enable=false \
	persist.vendor.vibrator.hal.context.scale=40 \
	persist.vendor.vibrator.hal.context.fade=true \
	persist.vendor.vibrator.hal.context.cooldowntime=1600 \
	persist.vendor.vibrator.hal.context.settlingtime=5000

# Identity credential
PRODUCT_PACKAGES += \
    android.hardware.identity-support-lib.vendor:64 \
    android.hardware.identity_credential.xml

# Nos
PRODUCT_PACKAGES += \
    libkeymaster4support.vendor:64 \
    libkeymint_support.vendor:64 \
    libnos:64 \
    libnosprotos:64 \
    libnos_client_citadel:64 \
    libnos_datagram:64 \
    libnos_datagram_citadel:64 \
    libnos_transport:64 \
    nos_app_avb:64 \
    nos_app_identity:64 \
    nos_app_keymaster:64 \
    nos_app_weaver:64 \
    pixelpowerstats_provider_aidl_interface-cpp.vendor:64

# Misc interfaces
PRODUCT_PACKAGES += \
    android.frameworks.stats-V1-ndk.vendor:32 \
    android.hardware.authsecret@1.0.vendor:64 \
    android.hardware.biometrics.common-V2-ndk.vendor:64 \
    android.hardware.biometrics.face-V2-ndk.vendor:64 \
    android.hardware.biometrics.face@1.0.vendor:64 \
    android.hardware.biometrics.fingerprint-V2-ndk.vendor:64 \
    android.hardware.input.common-V1-ndk.vendor:64 \
    android.hardware.input.processor-V1-ndk.vendor:64 \
    android.hardware.keymaster@3.0.vendor:64 \
    android.hardware.keymaster@4.0.vendor:64 \
    android.hardware.keymaster@4.1.vendor:64 \
    android.hardware.neuralnetworks-V4-ndk.vendor:64 \
    android.hardware.oemlock@1.0.vendor:64 \
    android.hardware.power@1.0.vendor:64 \
    android.hardware.power@1.1.vendor:64 \
    android.hardware.power@1.2.vendor:64 \
    android.hardware.radio.config@1.0.vendor \
    android.hardware.radio.config@1.1.vendor \
    android.hardware.radio.config@1.2.vendor \
    android.hardware.radio.deprecated@1.0.vendor \
    android.hardware.radio@1.2.vendor \
    android.hardware.radio@1.3.vendor \
    android.hardware.radio@1.4.vendor \
    android.hardware.radio@1.5.vendor \
    android.hardware.radio@1.6.vendor \
    android.hardware.secure_element@1.0.vendor:32 \
    android.hardware.secure_element@1.1.vendor:32 \
    android.hardware.secure_element@1.2.vendor:32 \
    android.hardware.thermal@1.0.vendor:32 \
    android.hardware.thermal@2.0.vendor:32 \
    android.hardware.weaver@1.0.vendor:64 \
    android.hardware.wifi@1.1.vendor:64 \
    android.hardware.wifi@1.2.vendor:64 \
    android.hardware.wifi@1.3.vendor:64 \
    android.hardware.wifi@1.4.vendor:64 \
    android.hardware.wifi@1.5.vendor:64 \
    android.hardware.wifi@1.6.vendor:64 \
    com.google.hardware.pixel.display-V4-ndk.vendor:64 \
    com.google.hardware.pixel.display-V5-ndk.vendor \
    com.google.hardware.pixel.display-V6-ndk.vendor
# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    android.hardware.fastboot@1.0-impl-mock.recovery \
    fastbootd 

# vndservicemanager and vndservice no longer included in API 30+, however needed by vendor code.
PRODUCT_PACKAGES += vndservicemanager
PRODUCT_PACKAGES += vndservice

# Hidl Service
PRODUCT_ENFORCE_VINTF_MANIFEST := true
PRODUCT_PACKAGES += \
    libhidltransport.vendor \
    libhwbinder.vendor
