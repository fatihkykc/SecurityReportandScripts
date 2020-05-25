AUTHLOG=/var/log/auth.log

if [[ -n $1 ]];
then
  AUTHLOG=$1
  echo Using Log file : $AUTHLOG
fi

# Collect the failed login attempts
FAILED_LOG=/tmp/failed.$$.log
egrep "Failed pass" $AUTHLOG > $FAILED_LOG 

# Collect the successful login attempts
SUCCESS_LOG=/tmp/success.$$.log
egrep "Accepted password|Accepted publickey|keyboard-interactive" $AUTHLOG > $SUCCESS_LOG

# extract the users who failed
failed_users=$(cat $FAILED_LOG | awk '{ print $(NF-5) }' | sort | uniq)

# extract the users who successfully logged in
success_users=$(cat $SUCCESS_LOG | awk '{ print $(NF-5) }' | sort | uniq)
# extract the IP Addresses of successful and failed login attempts
failed_ip_list="$(egrep -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" $FAILED_LOG | sort | uniq)"
success_ip_list="$(egrep -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" $SUCCESS_LOG | sort | uniq)"
if [[ ${failed_ip_list[@]}=0 ]]; then
    echo "there are no failed attempts!"
fi
# echo "success ip list $success_users"
difference=$(diff <(echo "$failed_ip_list") <(echo "$success_ip_list"))
diff <(echo "$failed_ip_list") <(echo "$success_ip_list")
