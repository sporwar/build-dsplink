#
#  ======== Makefile ========
#

include products.mak

.PHONY: dsplink

export DSPLINK=$(DSPLINK_INSTALL_DIR)/dsplink
#export XDC_INSTALL_DIR=/home/suren/ti-dvsdk_omapl138-evm_4_02_00_06/xdctools_3_16_03_36
#export IPC_INSTALL_DIR=/home/suren/ipc_1_00_05_60
#export XDCPATH="/home/suren/bios_6_21_03_21/packages;/home/suren/ipc_1_00_05_60/packages/"
export PATH:=$(DSPLINK)/etc/host/scripts/Linux:$(PATH)

GPP_OPTS= \
        DSPLINK=$(DSPLINK) \
        GPPROOT=$(DSPLINK)/gpp \
        BASE_BUILDOS=$(LINUX_KERNEL) \
        BASE_TOOLCHAIN=$(CS_ARM_INSTALL_DIR) \
        KERNEL_DIR=$(LINUX_KERNEL) \
        TOOL_PATH=$(CS_ARM_INSTALL_DIR)/bin \
        VERBOSE=1

DSP_OPTS= \
        DSPLINK=$(DSPLINK) \
        DSPROOT=$(DSPLINK)/dsp \
        BASE_SABIOS=$(BIOS_INSTALL_DIR) \
        BASE_CGTOOLS=$(TI_C6X_INSTALL_DIR) \
        BASE_RTDX=$(BIOS_INSTALL_DIR)/packages/ti/rtdx

help:
	@$(ECHO) ""
	@$(ECHO) "==== DSPLink makefile help ===="
	@$(ECHO) "Use these goals to build and clean DSPLink."
	@$(ECHO) ""
	@$(ECHO) "make dsplink"
	@$(ECHO) "make samples"
	@$(ECHO) "make all"
	@$(ECHO) "make clean"
	@$(ECHO) "make .show-products"
	@$(ECHO) ""
	@$(ECHO) "Be sure to update products.mak with correct product install"
	@$(ECHO) "paths. Use .show-products goal to check your settings. Edit"
	@$(ECHO) "this makefile to change DSPLink configuration options."


all: dsplink samples

dsplink: .dsplink-xdc
	@$(ECHO) "# Making $@ ..."
	@$(ECHO) "GPP_OPTS=$(GPP_OPTS)"
	$(MAKE) -C $(DSPLINK)/gpp/src $(GPP_OPTS) 
	$(MAKE) -C $(DSPLINK)/dsp/src $(DSP_OPTS) 

.dsplink-xdc: .dsplink-cfg
	@$(ECHO) "# Making $@ ..."
	$(XDC_INSTALL_DIR)/xdc .interfaces -P $(DSPLINK)/gpp
	$(XDC_INSTALL_DIR)/xdc clean -P $(DSPLINK)/gpp
	$(XDC_INSTALL_DIR)/xdc all -P $(DSPLINK)/gpp
	$(XDC_INSTALL_DIR)/xdc .interfaces -P $(DSPLINK)/dsp
	$(XDC_INSTALL_DIR)/xdc clean -P $(DSPLINK)/dsp
	$(XDC_INSTALL_DIR)/xdc all -P $(DSPLINK)/dsp

.dsplink-cfg:
	@$(ECHO) "# Making $@ ..."
	cd $(DSPLINK); perl config/bin/dsplinkcfg.pl \
            --platform=DA8XX --nodsp=1 --dspcfg_0=DA8XXGEMSHMEM \
            --dspos_0=DSPBIOS6XX --gppos=ARM --comps=ponslm --trace=0 \
            --DspTaskMode=1
	    

samples:
	$(MAKE) -C $(DSPLINK)/gpp/src/samples $(GPP_OPTS)
	$(MAKE) -C $(DSPLINK)/dsp/src/samples $(DSP_OPTS)

clean::
	$(MAKE) -C $(DSPLINK)/gpp/src clobber $(GPP_OPTS) 
	$(MAKE) -C $(DSPLINK)/gpp/src clean $(GPP_OPTS) 
	$(MAKE) -C $(DSPLINK)/dsp/src clobber $(DSP_OPTS) 
	$(MAKE) -C $(DSPLINK)/dsp/src clean $(DSP_OPTS) 
	$(XDC_INSTALL_DIR)/xdc clean -P $(DSPLINK)/gpp
	$(XDC_INSTALL_DIR)/xdc clean -P $(DSPLINK)/dsp
	rm -rf $(DSPLINK)/gpp/export/BIN
	rm -rf $(DSPLINK)/gpp/export/INCLUDE
	rm -f $(DSPLINK)/gpp/Global.xdc
	rm -f $(DSPLINK)/gpp/.xdcenv.mak
	rm -rf $(DSPLINK)/dsp/export/BIN
	rm -rf $(DSPLINK)/dsp/export/INCLUDE
	rm -f $(DSPLINK)/dsp/Global.xdc
	rm -f $(DSPLINK)/dsp/.xdcenv.mak
	rm -rf $(DSPLINK)/config/BUILD
	rm -f $(DSPLINK)/etc/host/scripts/Linux/multimake.sh
	find $(DSPLINK)/gpp -type f -name "\.*\.cmd" -exec rm {} \;


#  ======== standard macros ========
ifneq (,$(wildcard $(XDC_INSTALL_DIR)/bin/echo.exe))
    # use these on Windows
    CP      = $(XDC_INSTALL_DIR)/bin/cp
    ECHO    = $(XDC_INSTALL_DIR)/bin/echo
    MKDIR   = $(XDC_INSTALL_DIR)/bin/mkdir -p
    RM      = $(XDC_INSTALL_DIR)/bin/rm -f
    RMDIR   = $(XDC_INSTALL_DIR)/bin/rm -rf
else
    # use these on Linux
    CP      = cp
    ECHO    = echo
    MKDIR   = mkdir -p
    RM      = rm -f
    RMDIR   = rm -rf
endif
