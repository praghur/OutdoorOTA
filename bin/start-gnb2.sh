tmux new-session -d -s gnb2
tmux split-window -v
tmux attach-session -d -t gnb2
tmux set -g mouse
sudo /var/tmp/srsRAN_Project/build/apps/gnb/gnb -c /local/repository/etc/srsran/noho.meb.yml -c /local/repository/etc/srsran/qos.yaml
