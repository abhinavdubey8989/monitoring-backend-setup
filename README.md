

# Aim
- this repository is for POC purposes of how statsd , graphite , grafana work together.
- i have using a nodejs server for sending metric to statsd.

# How to start the components
- every component runs on docker (using docker-compose)
- each component has its separate directory (statsd , graphite , grafana , nodejs-server)
- inside each components directory there is a start_or_stop.sh  (instructions are present in the script)
- to get (statsd + graphite + grafana) up & running : run the start_or_stop_all.sh in the root dir
- to start the node-js bakckend server
    - cd to the node dir
    - run : nvm use v20.10.0
    - run : sudo ./start_or_stop.sh 1
- once everything is up , use the "call_api.sh" to hit the end-points (intx are mentioned in script)


# How to stop the components
- run : sudo ./start_or_stop.sh 0
- this will stop nodejs servers too , no need to seperately stop the nodejs servers


# Instructions for nodejs server
- run before hand : "nvm use v20.10.0" to avoid errors
- there are other statsd client packages as well like hot-shots , which we can use


# directory of counters stored in graphite
- stats_count.server_id.metric


# directory of timers stored in graphite
- stats.server_id.metric