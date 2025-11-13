ifeq ($(_THEOS_TARGET_LOADED),)
_THEOS_TARGET_LOADED := 1
THEOS_TARGET_NAME := watchos_simulator

_THEOS_TARGET_PLATFORM_NAME := watchsimulator
_THEOS_TARGET_PLATFORM_SDK_NAME := WatchSimulator
_THEOS_TARGET_PLATFORM_FLAG_NAME := watchos-simulator
_THEOS_TARGET_PLATFORM_SWIFT_NAME := apple-watchos
_THEOS_TARGET_PLATFORM_IS_SIMULATOR := $(_THEOS_TRUE)
_THEOS_DARWIN_CAN_USE_MODULES := $(_THEOS_TRUE)

NEUTRAL_ARCH := i386

include $(THEOS_MAKE_PATH)/targets/_common/darwin_head.mk
include $(THEOS_MAKE_PATH)/targets/_common/darwin_tail.mk

internal-install:: stage
	$(ECHO_NOTHING)install.exec "cp -a $(THEOS_STAGING_DIR)/ $(SIMJECT_ROOT)/ "$(ECHO_END)

internal-uninstall::
	$(ECHO_NOTHING)install.exec "find $(THEOS_STAGING_DIR) | tail -r | sed 's/^$(_THEOS_BACKSLASHED_STAGING_DIR)//' | grep '..*' | sed 's/^/$(BACKSLASHED_SIMJECT_ROOT)/' | tr '\n' '\0' | xargs -0 rm -df | true > /dev/null "$(ECHO_END)

setup:: stage internal-uninstall internal-install
remove:: internal-uninstall

_TARGET_OBJC_ABI_CFLAGS = -fobjc-abi-version=2 -fobjc-legacy-dispatch
_TARGET_OBJC_ABI_LDFLAGS = -Xlinker -objc_abi_version -Xlinker 2 -Xlinker -allow_simulator_linking_to_macosx_dylibs

_THEOS_TARGET_CFLAGS += $(_TARGET_OBJC_ABI_CFLAGS)
_THEOS_TARGET_LDFLAGS += $(_TARGET_OBJC_ABI_LDFLAGS)
THEOS_LIBRARY_PATH = $(THEOS)/lib/simulators
THEOS_VENDOR_LIBRARY_PATH = $(THEOS)/vendor/lib/simulators
endif
