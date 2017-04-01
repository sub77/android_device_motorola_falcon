#
# Copyright 2013-2016 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Sample: This is where we'd set a backup provider if we had one
# $(call inherit-product, device/sample/products/backup_overlay.mk)

# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720

# Inherit device configuration
$(call inherit-product, device/motorola/falcon/aosp_falcon.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/bliss/config/common.mk)
# $(call inherit-product, vendor/bliss/config/nfc_enhanced.mk)

PRODUCT_NAME := bliss_falcon
PRODUCT_DEVICE := falcon
PRODUCT_BRAND := motorola
PRODUCT_MODEL := Moto G
PRODUCT_MANUFACTURER := motorola
PRODUCT_RESTRICT_VENDOR_FILES := false

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=falcon \
    BUILD_FINGERPRINT="motorola/falcon/falcon:7.1.1/N4F26O/3582057:user/release-keys" \
    PRIVATE_BUILD_DESC="falcon-user 7.1.1 N4F26O 3582057 release-keys"
