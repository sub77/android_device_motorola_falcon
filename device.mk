# This file includes all definitions that apply to ALL find7a devices, and
# are also specific to find7a devices
#
# Everything in this directory will become public

# call the proprietary setup
$(call inherit-product, vendor/motorola/falcon/falcon-vendor.mk)

$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

LOCAL_PATH := device/motorola/falcon

DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/configs/mixer_paths.xml:system/etc/mixer_paths.xml

# Device specific packages
PRODUCT_PACKAGES += \
    SnapdragonCamera

# Ramdisk
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/init.target.rc:root/init.target.rc \
    $(LOCAL_PATH)/configs/fstab.qcom:root/fstab.qcom \
    $(LOCAL_PATH)/configs/twrp.fstab:recovery/root/etc/twrp.fstab

# Release tools CDMA APN list
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/apns-conf.xml:system/etc/apns-conf.xml \
    $(LOCAL_PATH)/configs/apns-conf-cdma.xml:system/etc/apns-conf-cdma.xml

# Telephony-ext
PRODUCT_PACKAGES += telephony-ext
PRODUCT_BOOT_JARS += telephony-ext

# Wifi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin

# Include common makefile
$(call inherit-product, device/motorola/msm8226-common/common.mk)
