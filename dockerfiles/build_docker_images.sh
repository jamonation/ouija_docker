#!/bin/bash

# Check to see if boot2docker is used
BOOT2DOCKER=$(which boot2docker)
if [ $? -eq 0 ]
then
    BOOT2DOCKERIP=$(boot2docker ip 2>&1|awk '{print $NF}'|grep -v "^$")
    SITE="$BOOT2DOCKERIP"
    printf "\n\033[1mFor reference, it looks like you're running boot2docker\033[m\n"
    printf "\n\033[1mPlease make a note of this if this setup fails and you need some help\033[m\n"
else
    # Not using boot2docker, so assume localhost is where alert manager will show up
    SITE="127.0.0.1"
fi

FIG=$(which fig)
if [ $? -eq 1 ]
then
    printf "\033[1mInstalling fig (http://www.fig.sh/) to manage docker development environment\033[m\n"
    pip install fig
else
    printf "\033[1mLooks like fig is already installed, continuing with Docker setup\033[m\n"
fi

printf "\n\033[1mCreating data container for MySQL persistence:\033[m\n"
docker build -t ateam/ouija_data ouija_data
docker run --name ouija_data ateam/ouija_data
if [ $? -eq 1 ]
then
    printf "\033[31mError creating MySQL application container. Run the following and then try this script again:\033[m\n"
    printf "\033[1mdocker ps -a -f status=exited |grep \"ouija_data\"| awk '{print \$1}' |xargs docker rm\033[m\n"
    printf "\033[31mExiting\033[m\n"
    exit 1
fi

printf "\033[1mCreating MySQL application container\033[m\n"
docker build -t ateam/ouija_db ouija_db
docker run --volumes-from ouija_data ateam/ouija_db /usr/local/bin/provision_mysql.sh

printf "\033[1mCreating ouija development application container\033[m\n"
docker build -t ateam/ouija_web ouija_web

cp fig.yml.template fig.yml
OUIJA_DIR=$(echo $PWD|sed 's/dockerfiles/ouija/')
printf "  volumes:\n" >> fig.yml
printf "    - $OUIJA_DIR:/srv/www/ouija\n" >> fig.yml 

printf "\033[1mCheck '\033[31mfig.yml\033[m\033[1m' in this directory.\033[m\n"
printf "\033[1mEnsure that the volumes: directive to points to your shared folder\033[m\n"
printf "\033[1mIt should be something like $OUIJA_DIR:/srv/www/ouija\033[m\n"
printf "\033[1mAfter you check/edit, you should be all set!\033[m\n"
printf "\n\033[1mWhen you're ready, run '\033[31mfig up\033[m\033[1m' and browse to:\nhttp://$SITE:8080\033[m\n"

