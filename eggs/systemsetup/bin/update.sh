#!/usr/bin/env bash

set -e

trap 'echo ""; echo -e "\033[0;31mSomething went wrong during the update!\n\nPlease review the output above carefully, correct the error, and retry the update.\033[0m"' ERR

update-confirm.sh
update-git.sh
update-perform.sh
update-ensure-installed.sh

read -p "Press enter to exit"
exit
