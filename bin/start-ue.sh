#For UE1
tmux new-session -d -s ue1
tmux attach-session -d -t ue1
tmux split-window -v
tmux set -g mouse
sudo quectel-CM -s internet -4
tmux split-window -v
sudo ip route add 10.45.0.121 via 10.45.0.1
#Install tshark 
sudo apt update
sudo apt install -y tshark
#Start packet capture
sudo tshark -i enx5e4cb4adde52 -T fields -e frame.time_epoch -e ip.src -e ip.dst -e ip.id -e udp.srcport -e udp.dstport -E header=y -E separator=, -E quote=d > ue1_results.csv
tmux split-window -v
sudo tcpdump -i enx5e4cb4adde52 -w ue1_capture.pcap
tmux split-window -v
/local/repository/bin/module-off.sh
/local/repository/bin/module-flight.sh
/local/repository/bin/module-on.sh



#For UE2
tmux new-session -d -s ue2
tmux split-window -v
tmux attach-session -d -t ue2
tmux set -g mouse
sudo quectel-CM -s internet -4
tmux split-window -v
sudo ip route add 10.45.3.10 via 10.45.0.1
#Install tshark 
sudo apt update
sudo apt install -y tshark
sudo tshark -i enxa686a3fc16a2 -T fields -e frame.time_epoch -e ip.src -e ip.dst -e ip.id -e udp.srcport -e udp.dstport -E header=y -E separator=, -E quote=d > ueTraff_results.csv
tmux split-window -v
sudo tcpdump -i enxa686a3fc16a2 -w ueTraff_capture.pcap
tmux split-window -v
/local/repository/bin/module-off.sh
/local/repository/bin/module-flight.sh
/local/repository/bin/module-on.sh


#For UE3
tmux new-session -d -s ue2
tmux split-window -v
tmux attach-session -d -t ue2
tmux set -g mouse
sudo quectel-CM -s internet -4
tmux split-window -v
sudo ip route add 10.45.2.10 via 10.45.0.1
/local/repository/bin/module-off.sh
/local/repository/bin/module-flight.sh
/local/repository/bin/module-on.sh


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



