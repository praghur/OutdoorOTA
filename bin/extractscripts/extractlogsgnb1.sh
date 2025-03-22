#!/bin/bash

# Define the log file
log_file="gnb1.log"

# Define the output CSV files
pucch_csv="pucch_gnb1.csv"
pusch_csv="pusch_gnb1.csv"
harq_csv_prefix="harq_gnb1"

max_rows=100000  # Set your desired maximum number of rows per CSV file
current_file_index=1
current_row_count=0

# Initialize the CSV files with headers
echo "timestamp,sinr,rsrp" > $pucch_csv
echo "timestamp,sinr" > $pusch_csv

# Initialize the first CSV file with headers
current_csv="${harq_csv_prefix}_${current_file_index}.csv"
echo "Timestamp,Type,H_ID" > $current_csv

# Read the log file line by line
while IFS= read -r line
do
    # Check for PUCCH entries
    if [[ $line == *"PUCCH"* ]]; then
        timestamp=$(echo $line | awk '{print $1}')
        rsrp=""
        sinr=""
        # Read the next lines to find SINR and RSRP values
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
    fi

    # Check for PUSCH entries
    if [[ $line == *"PUSCH"* ]]; then
        # Extract the timestamp
        timestamp=$(echo $line | awk '{print $1}')
        # Extract the sinr value
        sinr=$(echo $line | grep -oP 'sinr=\K[-+]?[0-9.]+')
        # Append the extracted values to the CSV file
        echo "$timestamp,$sinr" >> $pusch_csv
    fi

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
done < "$log_file"

echo "Extraction complete. Check ${harq_csv_prefix} , $pucch_csv and $pusch_csv for results."
