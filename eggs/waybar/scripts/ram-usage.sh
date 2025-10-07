#!/usr/bin/env bash

# Get CPU usage percentage
ram_used=$(free | awk '/Mem:/ {printf "%d", ($3/$2)*100}')
ram_stats=$(free --giga -h | awk '/Mem:/ {printf "Total Memory: %dGB\\nUsed Memory: %dGB", $2, $3}')

# Determine CPU state based on usage
if [ "$ram_used" -ge 90 ]; then
  state="Critical"
elif [ "$ram_used" -ge 70 ]; then
  state="High"
elif [ "$ram_used" -ge 40 ]; then
  state="Moderate"
else
  state="Low"
fi

# Set color based on CPU load
if [ "$ram_used" -ge 90 ]; then
  # If CPU usage is >= 90%, set color to #f38ba8
  text_output="<span color='#f38ba8'>󰀩 ${ram_used}%</span>"
else
  # Default color
  text_output=" ${ram_used}%"
fi

tooltip="${ram_stats}"
tooltip+="\nRAM Usage: ${state}"

# Module and tooltip
echo "{\"text\": \"$text_output\", \"tooltip\": \"$tooltip\"}"
