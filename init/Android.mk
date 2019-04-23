ifeq ($(TARGET_INIT_VENDOR_LIB),libinit_falcon)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional
LOCAL_C_INCLUDES := system/core/init
LOCAL_CPPFLAGS := -Wall -DANDROID_TARGET=\"$(TARGET_BOARD_PLATFORM)\"
LOCAL_SRC_FILES := init_falcon.cpp
LOCAL_MODULE := libinit_falcon
LOCAL_STATIC_LIBRARIES := \
    libbase liblog libutils

include $(BUILD_STATIC_LIBRARY)
endif
