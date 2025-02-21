tmux new-session -d -s cn5g
tmux split-window -v
tmux attach-session -d -t cn5g
tmux set -g mouse
sudo journalctl -u open5gs-amfd -u open5gs-smfd -u open5gs-nrfd -u open5gs-upfd -f --output cat

#Install tshark in UE1 and UE2
sudo apt update
sudo apt install -y tshark

#Continue with packet capture
sudo tshark -i ogstun -T fields -e frame.time_epoch -e ip.src -e ip.dst -e ip.id -e udp.srcport -e udp.dstport -E header=y -E separator=, -E quote=d > cn_results.csv
sudo tcpdump -i ogstun -w ogstun_capture.pcap

#Run alive script AFTER THIS
