$(call inherit-product, device/motorola/falcon/full_falcon.mk)

# Inherit some common aosp stuff.
$(call inherit-product, vendor/aosp/common.mk)

PRODUCT_RELEASE_NAME := MOTO G
PRODUCT_NAME := aosp_falcon

PRODUCT_GMS_CLIENTID_BASE := android-motorola
