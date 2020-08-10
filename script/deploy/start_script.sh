#!/bin/bash

if ! type getopt >/dev/null 2>&1 ; then
  echo "Error: command \"getopt\" is not found" >&2
  exit 1
fi

getopt_cmd=`getopt -o h -a -l redis-host:,redis-port:,redis-password:,exporter-host:,exporter-port:,exporter-uri: -n "start.sh" -- "$@"`
if [ $? -ne 0 ] ; then
    exit 1
fi
eval set -- "$getopt_cmd"

redis_host="127.0.0.1"
redis_port=6379
redis_password=""
exporter_host="127.0.0.1"
exporter_port=9121
exporter_uri="/metrics"

print_help() {
    echo "Usage:"
    echo "    start_script.sh [options]"
    echo "    start_script.sh --redis-host 127.0.0.1 --redis-port 6379 [options]"
    echo ""
    echo "Options:"
    echo "  -h, --help                 show help"
    echo "      --redis-host           the address of Redis server (\"127.0.0.1\" by default)"
    echo "      --redis-port           the port of Redis server (6379 by default)"
    echo "      --redis-password       the password to log in to Redis server"
    echo "      --exporter-host        the listen address of exporter (\"127.0.0.1\" by default)"
    echo "      --exporter-port        the listen port of exporter (9121 by default)"
    echo "      --exporter-uri         the uri to expose metrics (\"/metrics\" by defualt)"
}

while true
do
    case "$1" in
        -h | --help)
            print_help
            shift 1
            exit 0
            ;;
        --redis-host)
            case "$2" in
                "")
                    shift 2  
                    ;;
                *)
                    redis_host="$2"
                    shift 2;
                    ;;
            esac
            ;;
        --redis-port)
            case "$2" in
                "")
                    shift 2  
                    ;;
                *)
                    redis_port="$2"
                    shift 2;
                    ;;
            esac
            ;;
        --redis-password)
            case "$2" in
                "")
                    shift 2  
                    ;;
                *)
                    redis_password="$2"
                    shift 2;
                    ;;
            esac
            ;;
        --exporter-host)
            case "$2" in
                "")
                    shift 2  
                    ;;
                *)
                    exporter_host="$2"
                    shift 2;
                    ;;
            esac
            ;;
        --exporter-port)
            case "$2" in
                "")
                    shift 2  
                    ;;
                *)
                    exporter_port="$2"
                    shift 2;
                    ;;
            esac
            ;;
        --exporter-uri)
            case "$2" in
                "")
                    shift 2  
                    ;;
                *)
                    exporter_uri="$2"
                    shift 2;
                    ;;
            esac
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Error: argument \"$1\" is invalid" >&2
            echo ""
            print_help
            exit 1
            ;;
    esac
done

chmod +x ./src/redis_exporter

./src/redis_exporter --redis.addr="redis://$redis_host:$redis_port" --redis.password=$redis_password --web.listen-address=$exporter_host:$exporter_port --web.telemetry-path=$exporter_uri
