#!/bin/bash
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
    echo "Configuration file (config.ini) not found, please create a copy of config.ini.dist and modify the variables"
    exit 1
fi

# Read configuration file
cfg_parser 'config.ini'
cfg.section.mongo
cfg.section.docker

EXITED_STR=$( docker ps -f "name=$docker_name" -f 'status=exited' --format '{{.Names}}' )
RUNNING_STR=$( docker ps -f "name=$docker_name" --format '{{.Names}}' )

if [ "$EXITED_STR" == "$docker_name" ]; then
	echo "Starting stopped Mongo container..."
	docker start $docker_name

elif [ "$RUNNING_STR" == "$docker_name" ]; then
   echo "Restarting running Mongo container..."
   docker restart $docker_name

else 
	echo "Mongo container not set up yet, please run mongo_setup.sh"
fi
