CFG_TEE_TA_LOG_LEVEL ?= 4
CPPFLAGS += -DCFG_TEE_TA_LOG_LEVEL=$(CFG_TEE_TA_LOG_LEVEL)

# The UUID for the Trusted Application
BINARY=ea0ea0a8-f660-4435-8208-3c3d6c979722


-include $(TA_DEV_KIT_DIR)/mk/ta_dev_kit.mk

ifeq ($(wildcard $(TA_DEV_KIT_DIR)/mk/ta_dev_kit.mk), )
clean:
	@echo 'Note: $$(TA_DEV_KIT_DIR)/mk/ta_dev_kit.mk not found, cannot clean TA'
	@echo 'Note: TA_DEV_KIT_DIR=$(TA_DEV_KIT_DIR)'
endif
