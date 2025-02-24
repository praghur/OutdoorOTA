#!/bin/bash

# Define the input log file and output CSV files
log_file="logfile.log"
snr_csv="output.csv"
harq_csv="harq_logs.csv"

# Initialize the CSV files with headers
echo "Timestamp,SINR_EQ_SEL" > $snr_csv
echo "Timestamp,Type,H_ID" > $harq_csv

# Read the log file line by line
while IFS= read -r line
do
  # Check if the line contains "PUSCH" or "PDSCH"
  if [[ $line == *"PUSCH"* ]]; then
    # Extract the timestamp
    timestamp=$(echo $line | awk '{print $1}')
    
    # Read the next lines to find sinr_eq[sel]
    while IFS= read -r next_line
    do
      if [[ $next_line == *"sinr_eq[sel]="* ]]; then
        # Extract the sinr_eq[sel] value
        sinr_eq_sel=$(echo $next_line | grep -oP 'sinr_eq\[sel\]=\K[0-9.]+')
        
        # Append the extracted values to the CSV file
        echo "$timestamp,$sinr_eq_sel" >> $snr_csv
        break
      fi
    done
  fi
  
  # Check if the line contains "PUSCH" or "PDSCH" for harq_logs.csv
  if [[ $line == *"PUSCH"* || $line == *"PDSCH"* ]]; then
    # Extract the timestamp, type (PUSCH or PDSCH), and h_id
    timestamp=$(echo $line | awk '{print $1}')
    type=$(echo $line | grep -oP '(PUSCH|PDSCH)')
    h_id=$(echo $line | grep -oP 'h_id=\K[0-9]+')
    
    # Append the extracted values to the harq_logs.csv file
    echo "$timestamp,$type,$h_id" >> $harq_csv
  fi
done < $log_file

echo "Extraction complete. The CSV files are saved at $snr_csv and $harq_csv"
