#For UE1
tmux new-session -d -s ue1
tmux split-window -v
tmux attach-session -d -t ue1
tmux set -g mouse
sudo quectel-CM -s internet -4
tmux split-window -v
#Install tshark 
sudo apt update
sudo apt install -y tshark
#Start packet capture
sudo tshark -i enxfa1cc6cb0894 -T fields -e frame.time_epoch -e ip.src -e ip.dst -e ip.id -e udp.srcport -e udp.dstport -E header=y -E separator=, -E quote=d > ue1_results.csv
tmux split-window -v
sudo tcpdump -i enxfa1cc6cb0894 -w ue1_capture.pcap
tmux split-window -v
/local/repository/bin/module-off.sh
/local/repository/bin/module-flight.sh
/local/repository/bin/module-on.sh
sudo ip route add 10.45.0.121 via 10.45.0.1
#Run loopscript file
cd /local/repository/bin/
chmod +x loopscript.sh
./loopscript.sh



#For UE2
tmux new-session -d -s ue2
tmux split-window -v
tmux attach-session -d -t ue2
tmux set -g mouse
sudo quectel-CM -s internet -4
tmux split-window -v
#Install tshark 
sudo apt update
sudo apt install -y tshark
#Start packet capture
sudo tshark -i enxa686a3fc16a2 -T fields -e frame.time_epoch -e ip.src -e ip.dst -e ip.id -e udp.srcport -e udp.dstport -E header=y -E separator=, -E quote=d > ueTraff_results.csv
tmux split-window -v
sudo tcpdump -i enxa686a3fc16a2 -w ueTraff_capture.pcap
tmux split-window -v
/local/repository/bin/module-off.sh
/local/repository/bin/module-flight.sh
/local/repository/bin/module-on.sh
sudo ip route add 10.45.3.10 via 10.45.0.1


#For UE3
tmux new-session -d -s ue3
tmux split-window -v
tmux attach-session -d -t ue3
tmux set -g mouse
sudo quectel-CM -s internet -4
tmux split-window -v
/local/repository/bin/module-off.sh
/local/repository/bin/module-flight.sh
/local/repository/bin/module-on.sh
sudo ip route add 10.45.2.10 via 10.45.0.1

#For UE4
tmux new-session -d -s ue4
tmux split-window -v
tmux attach-session -d -t ue4
tmux set -g mouse
sudo quectel-CM -s internet -4
tmux split-window -v
#Install tshark 
sudo apt update
sudo apt install -y tshark
#Start packet capture
sudo tshark -i enx7a6202a42b3f -T fields -e frame.time_epoch -e ip.src -e ip.dst -e ip.id -e udp.srcport -e udp.dstport -E header=y -E separator=, -E quote=d > ue2_results.csv
tmux split-window -v
sudo tcpdump -i enx7a6202a42b3f -w ue2_capture.pcap
tmux split-window -v
/local/repository/bin/module-off.sh
/local/repository/bin/module-flight.sh
/local/repository/bin/module-on.sh
sudo ip route add 10.45.1.10 via 10.45.0.1




