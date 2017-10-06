# Bootloader
TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := MSM8226

# Platform
TARGET_BOARD_PLATFORM := msm8226
TARGET_BOARD_PLATFORM_GPU := qcom-adreno305

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_CPU_VARIANT := krait
ARCH_ARM_HAVE_TLS_REGISTER := true

# Kernel Prebuilt
#TARGET_PREBUILT_KERNEL := device/motorola/falcon/zImage-dtb
ifdef TARGET_PREBUILT_KERNEL
BOARD_CUSTOM_BOOTIMG_MK := device/motorola/falcon/mkbootimg.mk
BOARD_KERNEL_CMDLINE := androidboot.bootdevice=msm_sdcc.1 androidboot.hardware=qcom vmalloc=400M androidboot.selinux=permissive
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x01000000
endif

# Kernel Inline
ifndef TARGET_PREBUILT_KERNEL
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := androidboot.bootdevice=msm_sdcc.1 androidboot.hardware=qcom vmalloc=400M utags.blkdev=/dev/block/platform/msm_sdcc.1/by-name/utags androidboot.selinux=permissive
BOARD_KERNEL_IMAGE_NAME := zImage-dtb
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x01000000 --tags_offset 0x00000100
TARGET_KERNEL_ARCH := arm
TARGET_KERNEL_CONFIG := twrp/falcon_defconfig
TARGET_KERNEL_SOURCE := kernel/motorola/msm8226
TARGET_KERNEL_CROSS_COMPILE_PREFIX := arm-linux-androideabi-
endif

LZMA_RAMDISK_TARGETS := recovery

# Init
TARGET_INCREASES_COLDBOOT_TIMEOUT := true

# Recovery
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_HAS_NO_REAL_SDCARD := true
RECOVERY_SDCARD_ON_DATA := true

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 10485760
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 10485760
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1023410176
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5930598400 # 5930614784 - 16384
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64) macro
BOARD_SUPPRESS_SECURE_ERASE := true

# TWRP
TW_DEFAULT_EXTERNAL_STORAGE := true
TW_DEVICE_VERSION := 1
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXCLUDE_SUPERSU := true
TW_IGNORE_MAJOR_AXIS_0 := true
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_NTFS_3G := true
TW_NO_USB_STORAGE := true
TW_THEME := portrait_hdpi

TARGET_RECOVERY_IS_MULTIROM := true
#include vendor/extra/vcontrol/MR_REC_VERSION.mk
include device/motorola/falcon/multirom/BoardConfigMultirom.mk
ifeq ($(MR_REC_VERSION),)
MR_REC_VERSION := $(shell date +%Y%m%d)-01
endif
