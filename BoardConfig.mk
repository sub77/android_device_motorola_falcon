# inherit common device tree
-include device/motorola/msm8226-common/BoardConfigCommon.mk

LOCAL_PATH := device/motorola/falcon

TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := falcon
TARGET_OTA_ASSERT_DEVICE := xt1031,xt1032,xt1033,xt1034,falcon_umts,falcon_umtsds,falcon_cdma,falcon_retuaws,falcon,falcon_gpe
TARGET_BOARD_INFO_FILE := $(LOCAL_PATH)/board-info.txt

# Init
TARGET_INIT_VENDOR_LIB := libinit_falcon
TARGET_RECOVERY_DEVICE_MODULES := libinit_falcon
TARGET_UNIFIED_DEVICE := true

# Partition info
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x00F00000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x00F00000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1023410176
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5930598400
BOARD_CACHEIMAGE_PARTITION_SIZE := 694288384
BOARD_FLASH_BLOCK_SIZE := 131072

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth

WITH_DEXPREOPT := false

# Recovery:Start

TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/configs/fstab.qcom
RECOVERY_SDCARD_ON_DATA := true

# Release tools
TARGET_RELEASETOOLS_EXTENSIONS := $(LOCAL_PATH)

# inherit from the proprietary version
-include vendor/motorola/falcon/BoardConfigVendor.mk
