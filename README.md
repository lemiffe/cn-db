# CN DB

Init + Fixtures

## Local

- Run mongo_run.sh to start the mongo docker container
- Run python main.py (or python3 main.py) to run the fixtures + database upgrade scripts

## Deploys + Remote

- Deploy is automatic (circleci) after pushing to master branch
- Before first deploy, start mongo container manually on server (see mongo_run.sh)
- Server requirements: Docker