#!/bin/bash

memory_file="/home/vagrant/memo/memo.txt"
email_address="alphasaintnuel@gmail.com"

usage() {
	current_time=$(date +"%Y-%m-%d %H:%M:%S")
	memory_usage=$(free -m | awk 'NR == 2 { printf "%.2f%%", $3*100/2 }')
	echo "$current_time $memory_usage" >> "$memory_file"
}

send_report() {
	subject="Memory Usage - $(date +'%Y-%m-%d')"
	body=$(cat "$memory_file")
	echo "$body" | mail -s "$subject" "$email_address"
	rm "$memory_file"
}

midnight() {
	current_hour=$(date +"%H")
	if [ "$current_hour" == "00" ]; then
	send_report
	fi
}

while true; do
	usage
	midnight
	sleep 3600
done









