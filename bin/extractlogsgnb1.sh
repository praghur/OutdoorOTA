#!/bin/bash
#gNb1:
#HARQ ID - PUSCH
#SINR - PUSCH
# Define the input log file and output CSV files
log_file="gnb1.log"
snr_csv="snr_gnb1.csv"
harq_csv="harq_gnb1.csv"

# Initialize the CSV files with headers
echo "Timestamp,SINR_EQ_SEL" > $snr_csv
echo "Timestamp,H_ID" > $harq_csv

# Initialize the last processed timestamp variable and count
declare -A harq_count
last_timestamp=""
line_count=0
check_interval=30
max_interval=40
should_check=true

# Read the log file line by line
while IFS= read -r line
do
  # Increment the line count
  ((line_count++))

  # Check if we should check for "PUSCH"
  if $should_check; then
    # Check if the line contains "PUSCH"
    if [[ $line == *"PUSCH"* ]]; then
      # Extract the timestamp
      timestamp="${line%% *}"
      # Extract the h_id
      h_id=$(echo $line | grep -oP 'h_id=\K[0-9]+')
      # Append the extracted values to the harq_logs.csv file
      echo "$timestamp,$h_id" >> $harq_csv
      
      # Extract the seconds part of the timestamp
      timestamp_seconds=$(echo $timestamp | awk -F'[T:.]' '{print $4}')
      # Check if the current timestamp is different from the last processed timestamp
      if [[ $timestamp_seconds != $last_timestamp ]]; then
        # Extract the sinr value, including negative values
        sinr_eq_sel=$(echo $line | grep -oP 'sinr=\K-?[0-9.]+')
        # Append the extracted values to the CSV file
        echo "$timestamp,$sinr_eq_sel" >> $snr_csv
        
        # Update the last processed timestamp
        last_timestamp=$timestamp_seconds
      fi

      # Set the flag to false and reset the line count
      should_check=false
      line_count=0
    fi
  else
    # Check if the line count has reached the minimum interval
    if ((line_count >= check_interval)); then
      # Check if the line count has reached the maximum interval
      if ((line_count <= max_interval)); then
        # Reset the flag to true
        should_check=true
      fi
    fi
  fi
done < $log_file

echo "Extraction complete. The CSV files are saved at $snr_csv and $harq_csv"
