tmux new-session -d -s gnb1
tmux split-window -v
tmux attach-session -d -t gnb1
tmux set -g mouse
sudo /var/tmp/srsRAN_Project/build/apps/gnb/gnb -c /var/tmp/etc/srsran/noho.meb.yml -c /local/repository/etc/srsran/qos.yaml
