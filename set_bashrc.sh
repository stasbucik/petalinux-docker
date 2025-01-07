source common.sh

docker exec -it --user user $container_name bash -c " \
echo \"source /usr/petalinux_ver.sh\" >> ~/.bashrc && \
echo \"source /opt/Xilinx/petalinux/\\\$PETALINUX_VER/settings.sh\" >> ~/.bashrc && \
echo \"alias gco='git checkout'\" >> ~/.bashrc && \
echo \"alias glo='git log'\" >> ~/.bashrc && \
echo \"alias gla='git log --all --oneline --graph'\" >> ~/.bashrc && \
echo \"alias gst='git status'\" >> ~/.bashrc && \
echo \"alias gpull='git pull origin'\" >> ~/.bashrc && \
echo \"alias gbr='git branch'\" >> ~/.bashrc && \
echo \"alias gbra='git branch -a'\" >> ~/.bashrc && \
echo \"alias gsubinit='git submodule update --init'\" >> ~/.bashrc && \
echo \"alias gspu='git stash push'\" >> ~/.bashrc && \
echo \"alias gspo='git stash pop'\" >> ~/.bashrc && \
echo \"
\" >> ~/.bashrc"
