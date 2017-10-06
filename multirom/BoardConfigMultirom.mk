# MultiROM

BOARD_MKBOOTIMG_ARGS += --board mrom$(MR_REC_VERSION)

#still needed by multirom boot menu
DEVICE_RESOLUTION := 720x1280
MR_PIXEL_FORMAT := "RGBX_8888"
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness

MR_DEV_BLOCK_BOOTDEVICE := false
MR_NO_KEXEC := enabled

# MultiROM config
MR_DEVICE_VARIANTS := xt1031 xt1032 xt1033 xt1034
MR_DEVICE_VARIANTS += falcon_umts falcon_umtsds falcon_cdma falcon_retuaws falcon falcon_gpe
MR_INPUT_TYPE := type_b
MR_INIT_DEVICES := device/motorola/falcon/multirom/mr_init_devices.c
MR_DPI := hdpi
MR_DPI_FONT := 160
MR_DEVICE_HOOKS := device/motorola/falcon/multirom/mr_hooks.c
MR_DEVICE_HOOKS_VER := 4
MR_FSTAB := device/motorola/falcon/multirom/mrom.fstab
MR_USE_MROM_FSTAB := true
MR_KEXEC_MEM_MIN := 0x05000000
MR_KEXEC_DTB := true

#MR_USE_QCOM_OVERLAY := true
#MR_PIXEL_FORMAT := "RGBX_8888"
#MR_QCOM_OVERLAY_HEADER := device/motorola/falcon/multirom/overlay/mr_qcom_overlay.h
#MR_QCOM_OVERLAY_HEAP_ID_MASK := 2
#MR_QCOM_OVERLAY_CUSTOM_PIXEL_FORMAT := MDP_RGBX_8888
