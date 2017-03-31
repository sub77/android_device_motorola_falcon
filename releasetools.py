# Copyright (C) 2016 The CyanogenMod Project
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

import re

import common
import edify_generator

def FullOTA_Assertions(info):
  AddBootloaderAssertion(info, info.input_zip)


def FullOTA_PostValidate(info):
  ReplaceApnList(info)


def IncrementalOTA_Assertions(info):
  AddBootloaderAssertion(info, info.target_zip)


def IncrementalOTA_PostValidate(info):
  ReplaceApnList(info)


def AddBootloaderAssertion(info, input_zip):
  android_info = input_zip.read("OTA/android-info.txt")
  m = re.search(r"require\s+version-bootloader\s*=\s*(\S+)", android_info)
  if m:
    bootloaders = m.group(1).split("|")
    if "*" not in bootloaders:
      info.script.AssertSomeBootloader(*bootloaders)
    info.metadata["pre-bootloader"] = m.group(1)


def ReplaceApnList(info):
  info.script.AppendExtra('if getprop("ro.boot.radio") == "0x3" then')
  info.script.Mount("/system")
  info.script.AppendExtra('delete("/system/etc/apns-conf.xml");')
  info.script.AppendExtra('symlink("/system/etc/apns-conf-cdma.xml", "/system/etc/apns-conf.xml");')
  info.script.Unmount("/system")
  info.script.AppendExtra('endif;')


def InstallMagisk(info):
    magisk = info.input_zip.read("SYSTEM/addon.d/magisk.zip")
    common.ZipWriteStr(info.output_zip, "magisk/magisk.zip", magisk)


def InstallSuperSU(info):
    supersu = info.input_zip.read("SYSTEM/addon.d/UPDATE-SuperSU.zip")
    common.ZipWriteStr(info.output_zip, "supersu/UPDATE-SuperSU.zip", supersu)


def InstallSuperUser(info):
    superuser = info.input_zip.read("SYSTEM/addon.d/superuser.zip")
    common.ZipWriteStr(info.output_zip, "superuser/superuser.zip", superuser)


def GetOmniProps(info):
  info.script.AppendExtra('ifelse(is_mounted("/persist"), unmount("/persist"));')
  info.script.AppendExtra('mount("ext4", "EMMC", "/dev/block/bootdevice/by-name/persist", "/persist", "");')
  info.script.AppendExtra('ifelse(sha1_check(read_file("/persist/omnirom.prop")) == "",')
  info.script.AppendExtra('		(ui_print("/persist/omnirom.prop not found");),')
  info.script.AppendExtra('		(ui_print("/persist/omnirom.prop found");run_program("/sbin/busybox", "cp", "/persist/omnirom.prop", "/tmp/omnirom.prop");));')
  info.script.AppendExtra('ifelse(sha1_check(read_file("/sdcard/omnirom.prop")) == "",')
  info.script.AppendExtra('		(ui_print("/sdcard/omnirom.prop not found");),')
  info.script.AppendExtra('		(ui_print("/sdcard/omnirom.prop found");run_program("/sbin/busybox", "cp", "/sdcard/omnirom.prop", "/tmp/omnirom.prop");));')
  info.script.AppendExtra('unmount("/persist");')
  info.script.AppendExtra('ifelse(file_getprop("/tmp/omnirom.prop", "ro.sub.superuser") == "1",')
  info.script.AppendExtra('		(ui_print("ro.sub.superuser=1");package_extract_dir("superuser", "/tmp/superuser");run_program("/sbin/busybox", "unzip", "/tmp/supersu/superuser.zip", "META-INF/com/google/android/*", "-d", "/tmp/superuser");run_program("/sbin/busybox", "sh", "/tmp/superuser/META-INF/com/google/android/update-binary", "dummy", "1", "/tmp/superuser/superuser.zip");),')
  info.script.AppendExtra('		(ui_print("ro.sub.superuser=0");run_program("/sbin/busybox", "rm", "-rf", "system/app/SuperUser");));')
  info.script.AppendExtra('ifelse(file_getprop("/tmp/omnirom.prop", "ro.sub.supersu") == "1",')
  info.script.AppendExtra('		(ui_print("ro.sub.supersu=1");package_extract_dir("supersu", "/tmp/supersu");run_program("/sbin/busybox", "unzip", "/tmp/supersu/UPDATE-SuperSU.zip", "META-INF/com/google/android/*", "-d", "/tmp/supersu");run_program("/sbin/busybox", "sh", "/tmp/supersu/META-INF/com/google/android/update-binary", "dummy", "1", "/tmp/supersu/UPDATE-SuperSU.zip");),')
  info.script.AppendExtra('		(ui_print("ro.sub.supersu=0");run_program("/sbin/busybox", "rm", "-rf", "system/etc/init.d/99SuperSUDaemon");));')
  info.script.AppendExtra('ifelse(file_getprop("/tmp/omnirom.prop", "ro.sub.magisk") == "1",')
  info.script.AppendExtra('		(ui_print("ro.sub.magisk=1");package_extract_dir("magisk", "/tmp/magisk");run_program("/sbin/busybox", "unzip", "/tmp/magisk/magisk.zip", "META-INF/com/google/android/*", "-d", "/tmp/magisk");run_program("/sbin/busybox", "sh", "/tmp/magisk/META-INF/com/google/android/update-binary", "dummy", "1", "/tmp/magisk/magisk.zip");),')
  info.script.AppendExtra('		(ui_print("ro.sub.magisk=0");run_program("/sbin/busybox", "rm", "-rf", "system/app/MagiskManager");));')


def FlashSUperSU(info):
    info.script.AppendExtra(('ui_print("Flashing SuperSU...");'))
    info.script.AppendExtra(('package_extract_dir("supersu", "/tmp/supersu");'))
    info.script.AppendExtra(('run_program("/sbin/busybox", "unzip", "/tmp/supersu/UPDATE-SuperSU.zip", "META-INF/com/google/android/*", "-d", "/tmp/supersu");'))
    info.script.AppendExtra(('run_program("/sbin/busybox", "sh", "/tmp/supersu/META-INF/com/google/android/update-binary", "dummy", "1", "/tmp/supersu/UPDATE-SuperSU.zip");'))


def FlashMagisk(info):
    info.script.AppendExtra(('ui_print("Flashing Magisk...");'))
    info.script.AppendExtra(('package_extract_dir("magisk", "/tmp/magisk");'))
    info.script.AppendExtra(('run_program("/sbin/busybox", "unzip", "/tmp/magisk/magisk.zip", "META-INF/com/google/android/*", "-d", "/tmp/magisk");'))
    info.script.AppendExtra(('run_program("/sbin/busybox", "sh", "/tmp/magisk/META-INF/com/google/android/update-binary", "dummy", "1", "/tmp/magisk/magisk.zip");'))


def FullOTA_InstallEnd(info):
    InstallMagisk(info)
    InstallSuperSU(info)
    InstallSuperUser(info)
    GetOmniProps(info)
