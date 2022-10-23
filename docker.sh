#!/bin/bash

## Author: Emmanuel
##Date: oct 2022

yum update -y

if [ $? -ne 0 ]
then
    echo “someting when wrong during the upgrade!”
    exit 2
else
    yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
    if [ $? -ne 0 ]
    then
        echo “someting when wrong during the previous version remove!”
        exit 3
    else
        yum install -y yum-utils
        yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo
        if [ $? -ne 0 ]
        then
            echo “someting when wrong during the repository set up, please check the commands!”
            exit 4
        else
            yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin
            if [ $? -ne 0 ]
            then
                echo “someting when wrong during the installation, , please check the command”
                exit 5
            else
                systemctl start docker
                docker run hello-world
                if [ $? -ne 0 ]
                then
                    echo “Docker has been succesfully installed but having some problem to start!”
                    exit 6
                else
                    echo “Docker has been succesfully installed and running (-_-)!”
                fi
            fi
        fi
    fi
fi
