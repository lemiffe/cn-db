# CN DB

## Requirements

- Docker

## Setting up the database & container

- Run mongo_setup.sh to start the mongo docker container + set up the user, etc.
- Use mongo_restart.sh if you need to restart your mongo container (if it crashed or you rebooted)

## Loading fixtures + setting up indexes

- Load the database fixtures by executing `app/console database:fixtures`

## Running commands

- From the root directory run `app/console` to get a list of commands (synonym for python3 app/main.py)
- Run commands by executing `app/console insert:command:name {parameters}`

## Running database upgrade scripts

- Run upgrade scripts by executing `app/console database:upgrade`

## Clearing the database (remove all collections)

- Warning, this will destroy all data in the database: `app/console database:remove`

## Deploys + Remote

- Deploy is automated (circleci) after pushing to master branch
- After first deploy set up config.ini and then run mongo_setup.sh to set up a user and start the container