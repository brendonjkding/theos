ifeq ($(_THEOS_TARGET_LOADED),)
_THEOS_TARGET_LOADED := 1
THEOS_TARGET_NAME := appletvos_simulator

_THEOS_TARGET_PLATFORM_NAME := appletvos
_THEOS_TARGET_PLATFORM_SDK_NAME := AppleTVSimulator
_THEOS_TARGET_PLATFORM_FLAG_NAME := tvos-simulator
_THEOS_TARGET_PLATFORM_SWIFT_NAME := apple-tvos
_THEOS_TARGET_PLATFORM_IS_SIMULATOR := $(_THEOS_TRUE)
_THEOS_DARWIN_CAN_USE_MODULES := $(_THEOS_TRUE)

NEUTRAL_ARCH := x86_64

_THEOS_TARGET_DEFAULT_OS_DEPLOYMENT_VERSION := 9.0

include $(THEOS_MAKE_PATH)/targets/_common/darwin_head.mk
include $(THEOS_MAKE_PATH)/targets/_common/darwin_tail.mk

ifdef SIMULATOR
internal-install:: stage
	$(ECHO_NOTHING)install.exec "cp -r $(THEOS_STAGING_DIR)/ $(SIMULATOR_ROOT)/ "$(ECHO_END)

internal-uninstall::
	$(ECHO_NOTHING)install.exec "find $(THEOS_STAGING_DIR) | tail -r | sed 's/^$(_THEOS_BACKSLASHED_STAGING_DIR)//' | grep '..*' | sed 's/^/$(BACKSLASHED_SIMULATOR_ROOT)/' | tr '\n' '\0' | xargs -0 rm -df | true > /dev/null "$(ECHO_END)

setup:: internal-install
remove:: internal-uninstall
endif

_TARGET_OBJC_ABI_CFLAGS = -fobjc-abi-version=2 -fobjc-legacy-dispatch
_TARGET_OBJC_ABI_LDFLAGS = -Xlinker -objc_abi_version -Xlinker 2 -Xlinker -allow_simulator_linking_to_macosx_dylibs

_THEOS_TARGET_CFLAGS := -isysroot $(ISYSROOT) $(SDKFLAGS) $(_TARGET_OBJC_ABI_CFLAGS) $(MODULESFLAGS)
_THEOS_TARGET_LDFLAGS := -isysroot $(SYSROOT) $(SDKFLAGS) -multiply_defined suppress $(_TARGET_OBJC_ABI_LDFLAGS)
endif
