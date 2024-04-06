

# this script is for calling the api on node-server
# sample usage : 
#    - ./call_api 70 3033 (will call api 70 times on port 3033)
#    - ./call_api 30 4033 (will call api 30 times on port 4033)


call_api() {
    local PORT=$1
    MIN=500
    MAX=1000

    # generate random number b/w MIN & MAX
    RANDOM_NUM=$(( $RANDOM % (MAX - MIN + 1) + MIN ))

    curl --location "http://localhost:$PORT/statsd-poc" \
        --header 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
        --header 'Content-Type: application/json' \
        --data '{
            "inputTiming": '"$RANDOM_NUM"'
        }'
}


TIMES=$1
SERVER_PORT=$2


# defaults to 1 , ie call API only 1 time 
if [ -z "$TIMES" ] ; then
   TIMES=1
fi

# defaults to 3033 , ie call API on port 3033
if [ -z "$SERVER_PORT" ] ; then
   SERVER_PORT=3033
fi

# Iterate using for loop
for (( i=1; i<=$TIMES; i++ )); do
    call_api $SERVER_PORT
    echo " done : $i"
done


