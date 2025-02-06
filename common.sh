ubuntu_version="focal-20200916"
tini_version="v0.19.0"
tini_sig_key="595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7"
petalinux_version="2021.1"
image_name="ubuntu-$ubuntu_version-petalinux-$petalinux_version"
container_name="$image_name-buildenv"

INST_DIR=/opt/Xilinx/petalinux/2021.1
PETALINUX_INSTALLER_NAME=petalinux-v2021.1-final-installer.run
