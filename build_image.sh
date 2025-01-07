DOCKER_BUILDKIT=1

source common.sh

docker build \
    --build-arg INST_DIR=$INST_DIR \
    --build-arg PETALINUX_INSTALLER_NAME=$PETALINUX_INSTALLER_NAME \
    --build-arg PETALINUX_VER=$petalinux_version \
    --build-arg UBUNTU_VER=$ubuntu_version \
    --build-arg TINI_VER=$tini_version \
    --build-arg TINI_SIGN_KEY=$tini_sig_key \
    --progress plain -t $image_name .
