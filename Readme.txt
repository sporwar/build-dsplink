
1.Provide Paths(DSPLINK, BIOS, KERNEL, XDC, CGT) in Products.mak file

2. Export these before compiling the DSPLINK for ARM side, DSP side and Samples.
export XDC_INSTALL_DIR=/home/suren/ti-dvsdk_omapl138-evm_4_02_00_06/xdctools_3_16_03_36
export IPC_INSTALL_DIR=/home/suren/ipc_1_00_05_60
export XDCPATH="/home/suren/bios_6_21_03_21/packages;/home/suren/ipc_1_00_05_60/packages/"

3. make dsplink
	This would have created the binaries and libraries for both ARM and DSP side DSPLINK.
4. make samples 
	This creates the sample applications to test communication between ARM and DSP side DSPLINK.



