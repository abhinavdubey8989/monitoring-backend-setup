

# this script is for sending metric to statsd using terminal command
# below is the command to send a counter metric to statsd server
# echo "api.v1.post.user:1|c" | nc -w 1 -u localhost 8125

TIMES=$1

if [ -z "$TIMES" ] ; then
    echo "Invalid value of TIMES"
    exit 0
fi

for (( i=1; i<=$TIMES; i++ )); do
   echo "terminal.v1:1|c" | nc -w 1 -u localhost 8125
   echo "done : $i"
done