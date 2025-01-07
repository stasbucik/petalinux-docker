source common.sh

if [ ! -d $(pwd)/build-cache/petalinux-"$petalinux_version"-cache ] ; then
    mkdir -p -m 777 $(pwd)/build-cache/petalinux-"$petalinux_version"-cache/download
    mkdir -p -m 777 $(pwd)/build-cache/petalinux-"$petalinux_version"-cache/sstate-cache
fi

if [ "$1" != "skip" ] ; then
    mkdir -m 777 container-home
    mkdir -m 777 container-home/petalinux-cache
fi

docker create --name $container_name -it \
    --volume $(pwd)/container-home:/home/user \
    --volume $(pwd)/build-cache/petalinux-"$petalinux_version"-cache:/home/user/petalinux-cache \
    --publish 3022:22 $image_name

if [ "$1" != "skip" ] ; then
    docker start $container_name
    docker exec -it --user user $container_name cp -r /etc/skel/. /home/user
    docker exec -it --user user $container_name mkdir -m 777 /home/user/.ssh/
    cat ~/.ssh/container_key.pub >> container-home/.ssh/authorized_keys
    docker exec -it --user root $container_name chown -R user:user /home/user/.ssh/
    docker exec -it --user user $container_name chmod -R 700 /home/user/.ssh/
    docker exec -it --user user $container_name chmod -R 644 /home/user/.ssh/authorized_keys
    docker stop $container_name
fi
