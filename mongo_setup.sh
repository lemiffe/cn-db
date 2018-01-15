#!/bin/bash
shopt -s compat42 # For debian Jessie+ support

cfg_parser ()
{
    ini="$(<$1)"                # read the file
    ini="${ini//[/\[}"          # escape [
    ini="${ini//]/\]}"          # escape ]
    IFS=$'\n' && ini=( ${ini} ) # convert to line-array
    ini=( ${ini[*]//;*/} )      # remove comments with ;
    ini=( ${ini[*]/\    =/=} )  # remove tabs before =
    ini=( ${ini[*]/=\   /=} )   # remove tabs be =
    ini=( ${ini[*]/\ =\ /=} )   # remove anything with a space around =
    ini=( ${ini[*]/#\\[/\}$'\n'cfg.section.} ) # set section prefix
    ini=( ${ini[*]/%\\]/ \(} )    # convert text2function (1)
    ini=( ${ini[*]/=/=\( } )    # convert item to array
    ini=( ${ini[*]/%/ \)} )     # close array parenthesis
    ini=( ${ini[*]/%\\ \)/ \\} ) # the multiline trick
    ini=( ${ini[*]/%\( \)/\(\) \{} ) # convert text2function (2)
    ini=( ${ini[*]/%\} \)/\}} ) # remove extra parenthesis
    ini[0]="" # remove first element
    ini[${#ini[*]} + 1]='}'    # add the last brace
    eval "$(echo "${ini[*]}")" # eval the result
}

# Check if configuration exists
if [ ! -f config.ini ]; then
    echo "Configuration file (config.ini) not found, please create a copy of config.ini.dist and modify it!"
    exit 1
fi

# Read configuration file
cfg_parser 'config.ini'
cfg.section.mongo
cfg.section.docker

EXITED_STR=$( docker ps -f "name=$docker_name" -f 'status=exited' --format '{{.Names}}' )
RUNNING_STR=$( docker ps -f "name=$docker_name" --format '{{.Names}}' )

# Remove stopped container
if [ "$EXITED_STR" == "$docker_name" ]; then
    echo "Removing stopped container..."
    docker rm $docker_name
fi

# Remove running container
if [ "$RUNNING_STR" == "$docker_name" ]; then
    echo "Removing running container..."
    docker stop $docker_name
    docker rm $docker_name
fi

# Start container with no auth
echo "Start container with no auth..."
docker run --name $docker_name -v "$docker_volume_map" -p $docker_port:$docker_port --restart unless-stopped -d mongo

# Create user
sleep 5
echo "Create user..."
docker exec -it $docker_name mongo admin --eval "db.createUser({user: '$db_user', pwd: '$db_pwd', roles: ['root'] })"

# Stop container
echo "Stop container..."
docker stop $docker_name

# Remove container
echo "Remove container..."
docker rm $docker_name

# Start container with auth
echo "Start container with auth..."
docker run --name $docker_name -v "$docker_volume_map" -p $docker_port:$docker_port --restart unless-stopped -d mongo --auth
