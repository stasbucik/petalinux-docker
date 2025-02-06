ubuntu_version="jammy-20230301"
tini_version="v0.19.0"
tini_sig_key="595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7"
petalinux_version="2023.2"
image_name="ubuntu-$ubuntu_version-petalinux-$petalinux_version"
container_name="$image_name-buildenv"

INST_DIR=/opt/Xilinx/petalinux/2023.2
PETALINUX_INSTALLER_NAME=petalinux-v2023.2-10121855-installer.run
