#
#  ======== products.mak ========
#

DEPOT                   = /home/suren/ti-dvsdk_omapl138-evm_4_02_00_06

#BIOS_INSTALL_DIR        = $(DEPOT)/dspbios_5_41_03_17
BIOS_INSTALL_DIR        = /home/suren/bios_6_21_03_21
CS_ARM_INSTALL_DIR      = /opt/arm-2009q1
DSPLINK_INSTALL_DIR     = /home/suren/mds/dsplink_linux_1_65_02_09
LINUX_KERNEL            = /home/suren/mds/karthik/linux-03.22.00.02
TI_C6X_INSTALL_DIR      = $(DEPOT)/cgt6x_6_1_14
XDC_INSTALL_DIR         = $(DEPOT)/xdctools_3_16_03_36
IPC_INSTALL_DIR		= /home/suren/ipc_1_00_05_60

#export XDCPATH="/home/suren/bios_6_21_03_21/packages;/home/suren/ipc_1_00_05_60/packages/"
#export IPC_INSTALL_DIR=/home/suren/ipc_1_00_05_60

# use this goal to print your product variables
.show-products:
	@echo "BIOS_INSTALL_DIR         = $(BIOS_INSTALL_DIR)"
	@echo "CS_ARM_INSTALL_DIR       = $(CS_ARM_INSTALL_DIR)"
	@echo "DSPLINK_INSTALL_DIR      = $(DSPLINK_INSTALL_DIR)"
	@echo "LINUX_KERNEL             = $(LINUX_KERNEL)"
	@echo "TI_C6X_INSTALL_DIR       = $(TI_C6X_INSTALL_DIR)"
	@echo "XDC_INSTALL_DIR          = $(XDC_INSTALL_DIR)"
