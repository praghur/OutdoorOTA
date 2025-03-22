#!/bin/bash
#gNB2:
#HARQ ID: PDSCH
#SINR - PUSCH
# Define the input log file and output CSV files
log_file="gnb2.log"
snr_csv="snr_gnb2.csv"
harq_csv="harq_gnb2.csv"

# Initialize the CSV files with headers
echo "Timestamp,SINR_EQ_SEL" > $snr_csv
echo "Timestamp,H_ID" > $harq_csv

# Read the log file line by line
while IFS= read -r line
do
  # Check if the line contains "PUSCH"
  if [[ $line == *"PUSCH"* ]]; then
    # Extract the timestamp
    timestamp=$(echo $line | awk '{print $1}')
    # Extract the sinr value
    sinr_eq_sel=$(echo $line | grep -oP 'sinr=\K[0-9.]+')
    # Append the extracted values to the CSV file
        echo "$timestamp,$sinr_eq_sel" >> $snr_csv 
  fi
  
   # Check if the line contains "PDSCH"
   if [[ $line == *"PDSCH"* ]]; then
    # Extract the timestamp
    timestamp=$(echo $line | awk '{print $1}')
    # Extract the h_id
    h_id=$(echo $line | grep -oP 'h_id=\K[0-9]+')  
    # Append the extracted values to the harq_logs.csv file
    echo "$timestamp,$h_id" >> $harq_csv
  fi
done < $log_file

echo "Extraction complete. The CSV files are saved at $snr_csv and $harq_csv"
