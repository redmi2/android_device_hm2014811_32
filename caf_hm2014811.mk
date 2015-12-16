$(call inherit-product, device/qcom/common/base.mk)

# For PRODUCT_COPY_FILES, the first instance takes precedence.
# Since we want use QC specific files, we should inherit
# device-vendor.mk first to make sure QC specific files gets installed.
$(call inherit-product-if-exists, $(QCPATH)/common/config/device-vendor.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from hm2014811 device
$(call inherit-product, device/hm2014811/device.mk)

PRODUCT_NAME := caf_hm2014811
PRODUCT_DEVICE := hm2014811
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := 2014811
PRODUCT_BRAND := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

TARGET_VENDOR_PRODUCT_NAME := 2014811
TARGET_VENDOR_DEVICE_NAME := HM2014811
PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=HM2014811 \
    PRODUCT_NAME=2014811

## Use the latest approved GMS identifiers unless running a signed build
ifneq ($(SIGN_BUILD),true)
PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_FINGERPRINT=Xiaomi/2014811/HM2014811:4.4.4/KTU84P/V6.6.7.0.KHJMICF:user/release-keys \
    PRIVATE_BUILD_DESC="2014811-user 4.4.4 KTU84P HM2014811 release-keys"
endif
