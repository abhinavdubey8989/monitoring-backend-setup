

# this is a wrapper script over multiple start script
# run this script like : "./start_stop_all.sh 0" to stop all components
# run this script like : "./start_stop_all.sh 1" to start all components
# if $1 = 0 => stop  all rquired components
# if $1 = 1 => start all rquired components
# every component is started in detach mode , bcz value of $2 is not provided

IS_START=$1
BASE_DIR=$PWD 

if [ -z "$IS_START" ] ; then
    echo "provide 0 or 1 as 1st arg"
    exit 0
fi

# step-1 : start/stop statsd
STATSD_DIR=$BASE_DIR/statsd-server
cd $STATSD_DIR
if [ "$IS_START" -eq 1 ] ; then
    echo "starting $PWD ..."
    ./start_or_stop.sh 1
else
    echo "stopping $PWD ..."
    ./start_or_stop.sh 0
fi

# step-2 : start/stop graphite
GRAPHITE_DIR=$BASE_DIR/graphite
cd $GRAPHITE_DIR
if [ "$IS_START" -eq 1 ] ; then
    echo "starting $PWD ..."
    ./start_or_stop.sh 1
else
    echo "stopping $PWD ..."
    ./start_or_stop.sh 0
fi

# step-3 : start/stop graphana
GRAPHANA_DIR=$BASE_DIR/graphana
cd $GRAPHANA_DIR
if [ "$IS_START" -eq 1 ] ; then
    echo "starting $PWD ..."
    ./start_or_stop.sh 1
else
    echo "stopping $PWD ..."
    ./start_or_stop.sh 0
fi


# step-4 : start/stop node-js-app
NODE_APP_DIR=$BASE_DIR/client-nodejs-app
cd $NODE_APP_DIR
if [ "$IS_START" -eq 1 ] ; then
    echo "not starting $PWD ...as it needs sudo"
    # ./start_or_stop.sh 1 "a"
else
    echo "stopping $PWD ..."
    ./start_or_stop.sh 0
fi


# step-5 : logging only
docker ps
echo
if [ "$IS_START" -eq 1 ] ; then
    echo "all components started !!"
else
    echo "all components stopped !!"
fi
