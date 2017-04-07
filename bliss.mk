# Boot animation
TARGET_SCREEN_HEIGHT := 1080
TARGET_SCREEN_WIDTH := 720

# Inherit Bliss vendor
$(call inherit-product, vendor/bliss/config/common.mk)

# Inherit device configuration
$(call inherit-product, device/motorola/falcon/full_falcon.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := falcon
PRODUCT_NAME := bliss_falcon
PRODUCT_BRAND := motorola
PRODUCT_MODEL := Moto G
PRODUCT_MANUFACTURER := motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=falcon \
    BUILD_FINGERPRINT=google/falcon/falcon:7.0/NRD90M/3067468:user/release-keys \
    PRIVATE_BUILD_DESC="falcon-user 7.0 NRD90M 3067468 release-keys"
