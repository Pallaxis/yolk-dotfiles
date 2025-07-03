#!/usr/bin/env bash

#[[ $(uname -r) == $(ls /lib/modules | sort -V | tail -n 1) ]] && echo "✅ Kernel is up-to-date" || echo "⚠<fe0f>  Running old kernel: $(uname -r)"
#check_kernel() {
#  [[ $(uname -r) == $(ls /lib/modules | sort -V | tail -n 1) ]] && exit 0 || exit 1
#}
#
#check_kernel
#
#if [ $? -ne 0 ]; then
#  echo "not true"
#else
#  echo "true"
#fi

# Get the current running kernel version
current_kernel=$(uname -r)

# Get the latest installed kernel version in /lib/modules
latest_kernel=$(ls /lib/modules | sort -V | tail -n 1)

# Compare the two
if [[ "$current_kernel" == "$latest_kernel" ]]; then
  # Up-to-date: don't output anything (module hidden)
  exit 0
else
  # Not up-to-date: show warning
  echo "{\"text\": \"⚠️ Kernel: $current_kernel\", \"tooltip\": \"Latest available: $latest_kernel\", \"class\": \"warning\"}"
  exit 0
fi

