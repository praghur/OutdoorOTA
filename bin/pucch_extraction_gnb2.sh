#!/bin/bash

# Define the log file
log_file="gnb2.log"

# Define the output CSV file prefix
pucch_csv_prefix="pucch_gnb2"

max_rows=100000  # Set your desired maximum number of rows per CSV file
current_file_index=1
current_row_count=0

# Initialize the first CSV file with headers
pucch_csv="${pucch_csv_prefix}_${current_file_index}.csv"
echo "timestamp,sinr,rsrp" > $pucch_csv

# Read the log file line by line
while IFS= read -r line
do
    # Check for PUCCH entries
    if [[ $line == *"PUCCH"* ]]; then
        timestamp=$(echo $line | awk '{print $1}')
        rsrp=""
        sinr=""
        while IFS= read -r next_line
        do
            if [[ $next_line == *"rsrp="* ]]; then
                rsrp=$(echo $next_line | grep -oP 'rsrp=\K[-+]?[0-9.]+')
            fi  
            if [[ $next_line == *"sinr="* ]]; then
                sinr=$(echo $next_line | grep -oP 'sinr=\K[-+]?[0-9.]+')
                # Append the extracted values to the CSV file
                echo "$timestamp,$sinr,$rsrp" >> $pucch_csv
                break
            fi
        done
        echo "$timestamp,$sinr,$rsrp" >> $pucch_csv
        ((current_row_count++))

        # Check if the current CSV file has reached the maximum number of rows
        if (( current_row_count >= max_rows )); then
            ((current_file_index++))
            pucch_csv="${pucch_csv_prefix}_${current_file_index}.csv"
            echo "timestamp,sinr,rsrp" > $pucch_csv
            current_row_count=0
        fi
    fi
done < "$log_file"

echo "PUCCH extraction complete. Check ${pucch_csv_prefix} for results."
