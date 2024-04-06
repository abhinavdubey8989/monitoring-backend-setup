



# this script will start the components in attach/detach mode basis ATTACH_MODE_FLAG
# if ATTACH_MODE_FLAG is null or "d" => detach mode
# if ATTACH_MODE_FLAG is "a" => attach mode
# rest any value is invalid


./stop.sh

ATTACH_MODE_FLAG=$1
if [ -z "$ATTACH_MODE_FLAG" ] || [ "$ATTACH_MODE_FLAG" = "d" ]; then
    echo "detach mode"
    docker-compose up  -d
elif [ "$ATTACH_MODE_FLAG" = "a" ]; then
    echo "attach mode"
    docker-compose up
else
    echo "Invalid value of flag"
fi