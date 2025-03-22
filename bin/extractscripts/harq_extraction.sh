#!/bin/bash

# Define the log file
log_file="gnb1.log"

# Define the output CSV file prefix
harq_csv_prefix="harq_gnb1"

max_rows=100000  # Set your desired maximum number of rows per CSV file
current_file_index=1
current_row_count=0

# Initialize the first CSV file with headers
harq_csv="${harq_csv_prefix}_${current_file_index}.csv"
echo "Timestamp,Type,H_ID" > $harq_csv

# Read the log file line by line
while IFS= read -r line
do
    # Check for HARQ entries
    if [[ $line == *"PUSCH"* || $line == *"PDSCH"* && $line == *"h_id"* ]]; then
        timestamp=$(echo $line | awk '{print $1}')
        type=$(echo $line | grep -oP '(PUSCH|PDSCH)')
        h_id=$(echo $line | grep -oP 'h_id=\K[0-9]+')
        echo "$timestamp,$type,$h_id" >> $harq_csv
        ((current_row_count++))

        # Check if the current CSV file has reached the maximum number of rows
        if (( current_row_count >= max_rows )); then
            ((current_file_index++))
            harq_csv="${harq_csv_prefix}_${current_file_index}.csv"
            echo "Timestamp,Type,H_ID" > $harq_csv
            current_row_count=0
        fi
    fi
done < "$log_file"

echo "HARQ extraction complete. Check ${harq_csv_prefix} for results."
