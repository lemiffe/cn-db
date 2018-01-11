# CN DB

## Requirements

- Docker

## Local

- Run mongo_setup.sh to start the mongo docker container + set up the user, etc.
- Use mongo_restart.sh if you need to restart your mongo container (if it crashed or you rebooted)
- Run python main.py (or python3 main.py) to run the fixtures + database upgrade scripts

## Deploys + Remote

- Deploy is automated (circleci) after pushing to master branch
- After first deploy set up config.ini and then run mongo_setup.sh to set up a user and start the container