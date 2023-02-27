#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from penrose device
$(call inherit-product, device/blackshark/penrose/device.mk)

PRODUCT_DEVICE := penrose
PRODUCT_NAME := omni_penrose
PRODUCT_BRAND := blackshark
PRODUCT_MODEL := SHARK PRS-A0
PRODUCT_MANUFACTURER := blackshark

PRODUCT_GMS_CLIENTID_BASE := android-blackshark

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="PRS-A0-user 12 PROS2210210CN00AS1 V12.0.1.0.RBICNBS release-keys"

BUILD_FINGERPRINT := blackshark/PRS-A0/penrose:12/PROS2210210CN00AS1/V12.0.1.0.RBICNBS:user/release-keys
