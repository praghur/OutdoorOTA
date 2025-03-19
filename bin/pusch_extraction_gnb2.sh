#!/bin/bash

# Define the log file
log_file="gnb2.log"

# Define the output CSV file prefix
pusch_csv_prefix="pusch_gnb2"

max_rows=100000  # Set your desired maximum number of rows per CSV file
current_file_index=1
current_row_count=0

# Initialize the first CSV file with headers
pusch_csv="${pusch_csv_prefix}_${current_file_index}.csv"
echo "timestamp,sinr" > $pusch_csv

# Read the log file line by line
while IFS= read -r line
do
    # Check for PUSCH entries
    if [[ $line == *"PUSCH"* ]]; then
        timestamp=$(echo $line | awk '{print $1}')
        sinr=$(echo $line | grep -oP 'sinr=\K[-+]?[0-9.]+')
        echo "$timestamp,$sinr" >> $pusch_csv
        ((current_row_count++))

        # Check if the current CSV file has reached the maximum number of rows
        if (( current_row_count >= max_rows )); then
            ((current_file_index++))
            pusch_csv="${pusch_csv_prefix}_${current_file_index}.csv"
            echo "timestamp,sinr" > $pusch_csv
            current_row_count=0
        fi
    fi
done < "$log_file"

echo "PUSCH extraction complete. Check ${pusch_csv_prefix} for results."

