ARG UBUNTU_VER
FROM ubuntu:$UBUNTU_VER
ARG INST_DIR
ARG PETALINUX_INSTALLER_NAME
ARG PETALINUX_VER
ARG TINI_VER
ARG TINI_SIGN_KEY
ENV TZ=Europe/Ljubljana
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg --add-architecture i386 && \
    apt -y update && \
    apt -y upgrade && \
    apt -y install sudo locales iproute2 gawk python3 build-essential gcc git make \
        net-tools libncurses-dev tftpd-hpa zlib1g-dev libssl-dev flex bison \
        libselinux1 gnupg wget git-core diffstat chrpath socat xterm autoconf libtool tar \
        unzip texinfo gcc-multilib automake screen pax gzip cpio python3-pip \
        python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 \
        libegl1-mesa-dev libsdl1.2-dev rsync bc zlib1g:i386 expect xxd curl u-boot-tools pylint \
        libsodium-dev fakeroot e2fsprogs dosfstools parted mtools lsb-release libtinfo5 openssh-client openssh-server \
        nano psmisc curl unzip zip && \
    locale-gen en_US.UTF-8 && \
    ln -sf /bin/bash /bin/sh && \
    useradd -m -s /bin/bash user
# Install tini for signal processing and zombie killing
RUN set -eux; \
  wget -O /usr/local/bin/tini "https://github.com/krallin/tini/releases/download/${TINI_VER}/tini"; \
  wget -O /usr/local/bin/tini.asc "https://github.com/krallin/tini/releases/download/${TINI_VER}/tini.asc"; \
  export GNUPGHOME="$(mktemp -d)"; \
  gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$TINI_SIGN_KEY"; \
  gpg --batch --verify /usr/local/bin/tini.asc /usr/local/bin/tini; \
  command -v gpgconf && gpgconf --kill all || :; \
  rm -r "$GNUPGHOME" /usr/local/bin/tini.asc; \
  chmod +x /usr/local/bin/tini; \
  tini --version
RUN --mount=type=bind,src=./resources,target=/tmp/resources \
    mkdir -p "$INST_DIR" && \
    chown user:user "$INST_DIR" && \
    TMP_DIR=/home/user/petalinux-tmp && \
    sudo -u user mkdir "$TMP_DIR" && \
    cd "$TMP_DIR" && \
    cp "/tmp/resources/$PETALINUX_INSTALLER_NAME" "$TMP_DIR/$PETALINUX_INSTALLER_NAME" && \
    sudo chown user "$PETALINUX_INSTALLER_NAME" && \
    sudo -u user chmod +x "$PETALINUX_INSTALLER_NAME" && \
    sudo -u user cp /tmp/resources/accept-eula . && \
    sudo -u user chmod +x accept-eula && \
    sudo -u user -i "${TMP_DIR}/accept-eula" "${TMP_DIR}/$PETALINUX_INSTALLER_NAME" "$INST_DIR" && \
    chown root:root -R "$INST_DIR" && \
    cd && \
    sudo -u user rm -rf "$TMP_DIR" && \
    sudo -u user rm /home/user/petalinux_installation_log
RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config && \
    echo "PubkeyAuthentication yes" >> etc/ssh/sshd_config && \
    echo "StrictModes no" >> etc/ssh/sshd_config && \
    echo "AuthorizedKeysFile      .ssh/authorized_keys" >> /etc/ssh/sshd_config && \
    echo "export PETALINUX_VER=$PETALINUX_VER" > /usr/petalinux_ver.sh
USER user
CMD ["/usr/local/bin/tini", "/bin/bash"]
