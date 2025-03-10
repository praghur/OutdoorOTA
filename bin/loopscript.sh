#!/bin/bash

# Function to run traceroute 50 times randomly within an hour and write results to a CSV file
run_traceroute() {
  for i in {1..50}
  do
    result=$(traceroute -U -f 2 -m 2 -p 33435 -q 10 10.45.0.121)
    echo "$(date), $result" >> traceroute_results.csv
    sleep $((RANDOM % 56 + 5))  # Sleep for a random time between 5 to 60 seconds
  done
}

# Initialize the CSV file with headers
echo "Timestamp, Traceroute Result" > traceroute_results.csv

# Run the traceroute function every hour for 24 hours
for hour in {1..24}
do
  start_time=$(date +%s)  # Record the start time
  run_traceroute
  end_time=$(date +%s)  # Record the end time
  elapsed_time=$((end_time - start_time))  # Calculate the elapsed time
  sleep_time=$((3600 - elapsed_time))  # Calculate the remaining sleep time
  echo "Completed hour $hour"  # Display the hour at the end of each iteration
  sleep $sleep_time  # Sleep for the remaining time to complete the hour
done
