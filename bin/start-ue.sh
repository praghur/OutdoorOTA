#For UE1
tmux new-session -d -s ue1
tmux split-window -v
tmux attach-session -d -t ue1
tmux set -g mouse
sudo quectel-CM -s internet -4
/local/repository/bin/module-off.sh
/local/repository/bin/module-flight.sh
/local/repository/bin/module-on.sh
sudo ip route add 10.45.0.121 via 10.45.0.1


#For UE2
tmux new-session -d -s ue2
tmux split-window -v
tmux attach-session -d -t ue2
tmux set -g mouse
sudo quectel-CM -s internet -4
/local/repository/bin/module-off.sh
/local/repository/bin/module-flight.sh
/local/repository/bin/module-on.sh
sudo ip route add 10.45.3.10 via 10.45.0.1

#For UE3
tmux new-session -d -s ue2
tmux split-window -v
tmux attach-session -d -t ue2
tmux set -g mouse
sudo quectel-CM -s internet -4
/local/repository/bin/module-off.sh
/local/repository/bin/module-flight.sh
/local/repository/bin/module-on.sh
sudo ip route add 10.45.2.10 via 10.45.0.1

#For UE4
tmux new-session -d -s ue2
tmux split-window -v
tmux attach-session -d -t ue2
tmux set -g mouse
sudo quectel-CM -s internet -4
/local/repository/bin/module-off.sh
/local/repository/bin/module-flight.sh
/local/repository/bin/module-on.sh
sudo ip route add 10.45.1.10 via 10.45.0.1



