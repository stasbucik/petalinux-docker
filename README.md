How to use
==============================================

*Steps in italic are required when setting up for the first time.*

**Make sure docker daemon is running!**

- *Get petalinux installation file from [AMD](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html). Choose tar/gzip option*
- *Place the file into `resources` folder.*

- Select environment for your petalinux by checking out a speciffic tag:

`git checkout v2024.2`

- *Pull ubuntu image*

`source pull_ubuntu.sh`

- Build docker image

`source build_image.sh`

- *Create a keypair to use for connecting to container*

`ssh-keygen -f ~/.ssh/container_key -t rsa`

- *Create container and home directory*

`source create_container.sh`

or skip creation of home dir if you already have it setup

`source create_container.sh skip`

- Run the container

`source run_container.sh`

- Connect to the environment

`ssh -i ~/.ssh/container_key -p 3022 user@localhost`

You can create an entry in `~/.ssh/config` so you don't have to write the whole command every time

```
Host petalinux
  HostName localhost
  Port 3022
  User user
  IdentityFile /home/<username>/.ssh/container_key
```

Connect to container by running `ssh petalinux`.

How to setup shared sstate-cache and download:
==============================================

Put the following in `project-spec/meta-user/conf/petalinuxbsp.conf`
```
DL_DIR="/home/user/petalinux-cache/download"
SSTATE_DIR="/home/user/petalinux-cache/sstate-cache"
```
