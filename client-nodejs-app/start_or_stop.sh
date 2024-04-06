



stop() {
    docker-compose down
    docker container prune -f

    # the below removes all images whose name start with the "client-nodejs"
    docker images | grep "client-nodejs" | awk '{print $3}' | xargs docker image rm -f
    echo "stopped $PWD ..."
}


start_attach() {
    echo "attach mode"
    npm run build
    docker-compose up
}


start_detach() {
    echo "detach mode"
    npm run build
    docker-compose up -d
}



START_OR_STOP_FLAG=$1
ATTACH_MODE_FLAG=$2

if [ -z "$START_OR_STOP_FLAG" ] ; then
    echo "Invalid value of start/stop flag"
    exit 0
elif [ "$START_OR_STOP_FLAG" = "0" ]; then
    stop
    exit 0
elif [ "$START_OR_STOP_FLAG" != "1" ]; then
    echo "Invalid value of start/stop flag"
    exit 0
fi


stop
if [ -z "$ATTACH_MODE_FLAG" ] || [ "$ATTACH_MODE_FLAG" = "d" ]; then
    start_detach
elif [ "$ATTACH_MODE_FLAG" = "a" ]; then
    start_attach
else
    echo "Invalid value of flag"
fi