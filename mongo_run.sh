#!/bin/bash
[[ $(docker ps -f 'name=cn-db' --format '{{.Names}}') == 'cn-db' ]] || docker run --name cn-db -v ~/mongodata:/data/db -d mongo
