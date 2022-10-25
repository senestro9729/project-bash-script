#!/bin/bash

## Author: ibrahim
##Date: oct 2022

yum install java-11-openjdk-devel -y

if [ $? -ne 0 ]
then
    echo “someting went wrong during the java installation!”
    exit 2
else
    curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
    rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
    if [ $? -ne 0 ]
    then
        echo “someting went wrong when adding jenkins repository!”
        exit 2
    else
        yum install jenkins -y
        if [ $? -ne 0 ]
        then
            echo “someting went wrong during the Jenkins installation!”
            exit 2
        else
            systemctl start jenkins
            sudo systemctl enable jenkins
            if [ $? -ne 0 ]
            then
                echo “someting went wrong when starting Jenkins”
                exit 2
            else
                firewall-cmd --permanent --zone=public --add-port=8080/tcp
                firewall-cmd --reload               
                systemctl status jenkins
                echo “Jenkins has been succesfully installed and running !”
                
            fi
        fi
    fi
fi
