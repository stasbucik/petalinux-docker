source common.sh

docker start $container_name
docker exec -it --user root $container_name service ssh start
