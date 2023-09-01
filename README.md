# MySQL to Postgres dump file converter

## Requirements

Tools required to use this project:
* Bash >= 4
* Make
* [Docker](https://docs.docker.com/engine/install)
* [Docker compose](https://docs.docker.com/compose/install) >= 1.26.0

### Note for Linux

Do not forget the [post-installation steps](https://docs.docker.com/engine/install/linux-postinstall)!

## Usage

1. Place your MySQL dump file into the *input* directory.
2. Spin up the containers: ```make up```
3. Execute the script: ```make migrate```
4. Your Postgres compatible dump file should apprear in the *output* directory.
5. ... profit !

### If you want to convert another dump file

1. Spin the containers down : ```make down```
2. Replace the dump file into the *input* directory.
3. Spin the containers back up: ```make up```
4. Execute the script again: ```make migrate```
5. Grab you new converted dump into the *output* directory.

## Troubleshooting

* Place only one dump file at a time in the *input* directory.
* The MySQL container might take a few minutes to spin up because it is importing the dump file from the *input* directory during the build phase.
* Wait a few seconds between the ```make up``` and ```make migrate``` commands for the Postgres container to spin up properly.

## Roadmap

* Add env variable to manage the Postgres and MySQL versions
* Add env varibale to control the parameters passed to pgloader
* Add env variable to control the parameters passed to pg_dump
