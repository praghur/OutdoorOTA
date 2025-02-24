#!/bin/bash

# Define the log file and output CSV files
log_file="/home/ubuntu/gnb1.log"
output_csv1="/home/ubuntu/snr_logs.csv"
output_csv2="/home/ubuntu/harq_logs.csv"

# Print the CSV headers
echo "Timestamp, SINR_eq[sel]" > $output_csv1
echo "Log Line" > $output_csv2

# Read the log file line by line
while IFS= read -r line; do
    # Check if the line contains "sinr_eq[sel]"
    if [[ $line == *"sinr_eq[sel]"* ]]; then
        # Extract the timestamp from the previous line containing "PUSCH"
        timestamp=$(grep -B 40 "sinr_eq[sel]" "$log_file" | grep "PUSCH" | awk '{print $1}')
        
        # Extract the sinr_eq[sel] value
        sinr_eq=$(echo $line | grep -oP 'sinr_eq\[sel\]=\K[^\s]+')
        
        # Append the timestamp and sinr_eq[sel] value to the CSV file
        echo "$timestamp, $sinr_eq" >> $output_csv
    fi
done < "$log_file"

echo "Extraction complete. The CSV files are saved at $output_csv1 and $output_csv2"
