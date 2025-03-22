#!/bin/bash

# Define the input log file and output CSV files
log_file="gnb2_harq.log"
harq_csv_prefix="harq_logs_gnb2"
max_rows=100000  # Set your desired maximum number of rows per CSV file
current_file_index=1
current_row_count=0

# Initialize the first CSV file with headers
current_csv="${harq_csv_prefix}_${current_file_index}.csv"
echo "Timestamp,Type,H_ID" > $current_csv

# Read the log file line by line
while IFS= read -r line
do
  # Check if the line contains "PUSCH" or "PDSCH" for harq_logs.csv
  if [[ $line == *"PUSCH"* || $line == *"PDSCH"* && $line == *"h_id"* ]]; then
    # Extract the timestamp, type (PUSCH or PDSCH), and h_id
    timestamp=$(echo $line | awk '{print $1}')
    type=$(echo $line | grep -oP '(PUSCH|PDSCH)')
    h_id=$(echo $line | grep -oP 'h_id=\K[0-9]+')
    
    # Append the extracted values to the current CSV file
    echo "$timestamp,$type,$h_id" >> $current_csv
    ((current_row_count++))
    
    # Check if the current CSV file has reached the maximum number of rows
    if (( current_row_count >= max_rows )); then
      # Increment the file index and reset the row count
      ((current_file_index++))
      current_csv="${harq_csv_prefix}_${current_file_index}.csv"
      echo "Timestamp,Type,H_ID" > $current_csv
      current_row_count=0
    fi
  fi
done < $log_file

echo "Extraction complete. The CSV files are saved with the prefix ${harq_csv_prefix}_"
