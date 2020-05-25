#!/bin/bash
USERS="$(awk -F: '$3 >= 1000 && $1 != "nobody" { print $1 }' /etc/passwd)"
# echo "${#USERS[@]}"
for u in $USERS
do
    # check for users with no passwords. 
    passwd -S $u | grep -Ew "NP" >/dev/null
    if [ $? -eq 0 ]; then
        echo "there are users with no password."
        passwd -l $u
    else
	echo "no empty passwords for users"
    fi
done

# check for uid 0 other than root
REDFLAG=$(cat /etc/passwd | awk -F: '($3 == 0) { print $1 }')

if [[ ${#REDFLAG[@]} -gt 1 ]]; then
    echo "THERE ARE MORE THAN ONE USER WİTH UID 0"
else
    echo "there is only 1 user with uid 0"
fi
