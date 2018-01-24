TARGET_USES_AOSP_FOR_AUDIO := true
TARGET_USES_AOSP := true
TARGET_USES_QCOM_BSP := false

TARGET_USES_HWC2 := true

DEVICE_PACKAGE_OVERLAYS := device/qcom/msm8916_32/overlay

ifeq ($(TARGET_PRODUCT),msm8916_32)
TARGET_USES_NQ_NFC := false
endif

# Add QC Video Enhancements flag
TARGET_ENABLE_QC_AV_ENHANCEMENTS := false

# Enable features in video HAL that can compile only on this platform
TARGET_USES_MEDIA_EXTENSIONS := true

#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk

#for android_filesystem_config.h
PRODUCT_PACKAGES += \
    fs_config_files

# media_profiles and media_codecs xmls for 8916
ifneq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/qcom/msm8916_32/media/media_profiles_8916.xml:system/etc/media_profiles.xml \
                      device/qcom/msm8916_32/media/media_profiles_8916.xml:system/vendor/etc/media_profiles.xml \
                      device/qcom/msm8916_32/media/media_codecs_8916.xml:system/vendor/etc/media_codecs.xml \
                      device/qcom/msm8916_32/media/media_codecs_performance_8916_32.xml:system/etc/media_codecs_performance.xml \
                      device/qcom/msm8916_32/media/media_codecs_performance_8916_64_8939.xml:system/etc/media_codecs_performance_8939.xml \
                      device/qcom/msm8916_32/media/media_codecs_8939.xml:system/etc/media_codecs_8939.xml \
                      device/qcom/msm8916_32/media/media_codecs_8929.xml:system/etc/media_codecs_8929.xml
endif

PRODUCT_PROPERTY_OVERRIDES += \
       dalvik.vm.heapgrowthlimit=128m \
       dalvik.vm.heapminfree=6m \
       dalvik.vm.heapstartsize=14m
$(call inherit-product, device/qcom/common/common.mk)

PRODUCT_NAME := msm8916_32
PRODUCT_DEVICE := msm8916_32

# When can normal compile this module,  need module owner enable below commands
# font rendering engine feature switch
-include $(QCPATH)/common/config/rendering-engine.mk
ifneq (,$(strip $(wildcard $(PRODUCT_RENDERING_ENGINE_REVLIB))))
    #MULTI_LANG_ENGINE := REVERIE
#   MULTI_LANG_ZAWGYI := REVERIE
endif

# add vendor manifest file
PRODUCT_COPY_FILES += \
    device/qcom/msm8916_32/manifest.xml:$(TARGET_COPY_OUT_VENDOR)/manifest.xml

PRODUCT_BOOT_JARS += \
           qcom.fmradio

PRODUCT_BOOT_JARS += tcmiface
#PRODUCT_BOOT_JARS += qcmediaplayer

# QTI extended functionality of android telephony.
# Required for MSIM manual provisioning and other related features.
PRODUCT_PACKAGES += telephony-ext
PRODUCT_BOOT_JARS += telephony-ext

ifneq ($(strip $(QCPATH)),)
#PRODUCT_BOOT_JARS += com.qti.dpmframework
#PRODUCT_BOOT_JARS += dpmapi
#PRODUCT_BOOT_JARS += com.qti.location.sdk
PRODUCT_BOOT_JARS += oem-services
endif

PRODUCT_BOOT_JARS += WfdCommon

# Audio configuration file
-include $(TOPDIR)hardware/qcom/audio/configs/msm8916_32/msm8916_32.mk

# ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    camera2.portability.force_api=1

# Feature definition files for msm8916
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml

PRODUCT_PACKAGES += \
    libqcomvisualizer \
    libqcompostprocbundle \
    libqcomvoiceprocessing

#OEM Services library
PRODUCT_PACKAGES += oem-services
PRODUCT_PACKAGES += libsubsystem_control
PRODUCT_PACKAGES += libSubSystemShutdown

PRODUCT_PACKAGES += wcnss_service

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    device/qcom/msm8916_32/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf

#wlan driver
PRODUCT_COPY_FILES += \
    device/qcom/msm8916_32/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini \
    device/qcom/msm8916_32/WCNSS_wlan_dictionary.dat:persist/WCNSS_wlan_dictionary.dat \
    device/qcom/msm8916_32/WCNSS_qcom_wlan_nv.bin:persist/WCNSS_qcom_wlan_nv.bin

PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf
#for wlan
   PRODUCT_PACKAGES += \
       wificond \
       wifilogd

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml

#ANT+ stack
PRODUCT_PACKAGES += \
AntHalService \
libantradio \
antradio_app

# Display/Gralloc
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.mapper@2.0-impl \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    android.hardware.light@2.0-impl \
    android.hardware.light@2.0-service \
    android.hardware.configstore@1.0-service \
    android.hardware.broadcastradio@1.0-impl

#PRODUCT_FULL_TREBLE_OVERRIDE := true

PRODUCT_VENDOR_MOVE_ENABLED := true

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.0-impl \
    android.hardware.vibrator@1.0-service \

#HBTP
PRODUCT_PACKAGES += hbtp_daemon
PRODUCT_PACKAGES += libhbtpclient.so
PRODUCT_PACKAGES += libhbtpfrmwk.so
PRODUCT_PACKAGES += libhbtparm.so
PRODUCT_PACKAGES += libafehal_5_rohm_v3.so
PRODUCT_PACKAGES += hbtp_8939_5_rohm_v3.cfg
PRODUCT_PACKAGES += hbtpcfg_8939_5_rohm_v3.dat
PRODUCT_PACKAGES += libafehal_5_rohm_v4.so
PRODUCT_PACKAGES += hbtp_8939_5_rohm_v4.cfg
PRODUCT_PACKAGES += hbtpcfg_8939_5_rohm_v4.dat
PRODUCT_PACKAGES += libafehal_5p5_rohm_v4.so
PRODUCT_PACKAGES += hbtp_8939_5p5_rohm_v4.cfg
PRODUCT_PACKAGES += hbtpcfg_8939_5p5_rohm_v4.dat
PRODUCT_PACKAGES += libafehal_6_rohm_v3.so
PRODUCT_PACKAGES += hbtp_8939_6_rohm_v3.cfg
PRODUCT_PACKAGES += hbtpcfg_8939_6_rohm_v3.dat

# Defined the locales
PRODUCT_LOCALES += th_TH vi_VN tl_PH hi_IN ar_EG ru_RU tr_TR pt_BR bn_IN mr_IN ta_IN te_IN zh_HK \
        in_ID my_MM km_KH sw_KE uk_UA pl_PL sr_RS sl_SI fa_IR kn_IN ml_IN ur_IN gu_IN or_IN zh_CN

# When can normal compile this module,  need module owner enable below commands
# Add the overlay path
#PRODUCT_PACKAGE_OVERLAYS := $(QCPATH)/qrdplus/Extension/res \
        $(QCPATH)/qrdplus/globalization/multi-language/res-overlay \
        $(PRODUCT_PACKAGE_OVERLAYS)

# Sensor HAL conf file
PRODUCT_COPY_FILES += \
    device/qcom/msm8916_32/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

#FEATURE_OPENGLES_EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml

#Boot control HAL test app
PRODUCT_PACKAGES_DEBUG += bootctl

#Healthd packages
PRODUCT_PACKAGES += android.hardware.health@1.0-impl \
                    android.hardware.health@1.0-convert \
                    android.hardware.health@1.0-service \
                    libhealthd.msm
#Supports verity
PRODUCT_SUPPORTS_VERITY := false

PRODUCT_PACKAGES += \
    vendor.display.color@1.0-service

# Fingerprint feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:system/etc/permissions/android.hardware.fingerprint.xml \

PRODUCT_PACKAGES += \
    android.hardware.audio@2.0-service \
    android.hardware.audio@2.0-impl \
    android.hardware.audio.effect@2.0-impl \
    android.hardware.soundtrigger@2.0-impl

# Power
PRODUCT_PACKAGES += \
    android.hardware.power@1.0-service \
    android.hardware.power@1.0-impl

# Camera configuration file. Shared by passthrough/binderized camera HAL
PRODUCT_PACKAGES += camera.device@1.0-impl
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-impl
# Enable binderized camera HAL
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-service

KMGK_USE_QTI_SERVICE := false
#Enable Google KEYMASTER and GATEKEEPER HIDLs
ifneq ($(KMGK_USE_QTI_SERVICE), true)
  PRODUCT_PACKAGES += android.hardware.gatekeeper@1.0-impl \
                      android.hardware.gatekeeper@1.0-service \
                      android.hardware.keymaster@3.0-impl \
                      android.hardware.keymaster@3.0-service
endif
