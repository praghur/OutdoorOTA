#Save results from CN
scp root@pc11-fort.emulab.net:/local/repository/bin/cn_results.csv /home/ubuntu/
scp root@pc11-fort.emulab.net:ogstun_capture.pcap /home/ubuntu/

#Save results from UE1
scp root@ota-nuc1.emulab.net:/local/repository/bin/ue1_results.csv /home/ubuntu/
scp root@ota-nuc1.emulab.net:ue1_capture.pcap /home/ubuntu/
scp root@ota-nuc1.emulab.net:/local/repository/bin/traceroute_results.csv /home/ubuntu/

#Save results from UE4
scp root@nuc1.web.powderwireless.net:ue2_results.csv /home/ubuntu/
scp root@nuc1.web.powderwireless.net:ue2_capture.pcap /home/ubuntu/

#Save results from UE2 - Background data
scp root@ota-nuc2.emulab.net:ueTraff_results.csv /home/ubuntu/
scp root@ota-nuc2.emulab.net:/local/repository/bin/ueTraff_capture.pcap /home/ubuntu/

#Save results from gnb1
scp root@pc05-fort.emulab.net:/tmp/gnb1_mac.pcap /home/ubuntu/
scp root@pc05-fort.emulab.net:/tmp/gnb1_ngap.pcap /home/ubuntu/
scp root@pc05-fort.emulab.net:/tmp/gnb1-trace.log /home/ubuntu/
scp root@pc05-fort.emulab.net:/tmp/gnb1.log /home/ubuntu/

#Save results from gnb2
scp root@pc01-meb.emulab.net:/tmp/gnb2_mac.pcap /home/ubuntu/
scp root@pc01-meb.emulab.net:/tmp/gnb2_ngap.pcap /home/ubuntu/
scp root@pc01-meb.emulab.net:/tmp/gnb2-trace.log /home/ubuntu/
scp root@pc01-meb.emulab.net:/tmp/gnb2.log /home/ubuntu/



