#!/bin/bash

## Author: ibrahim
##Date: oct 2022

osversion=$(egrep '^(NAME)=' /etc/os-release)
echo $var
echo $osversion
#sleep 4
if [ "$osversion" == 'NAME="CentOS Linux"' ];

then
        yum install httpd -y
        if [ $? -eq 0 ]
        then
                echo “Apache installed succesfully!!!”
        else
                echo "Something went wrong: Apache did not install"
        fi
 else
        if [ "$osversion" == 'NAME="Ubuntu"' ];

        then
            apt install apache2 -y
            if [ $? -eq 0 ]
            then
                    echo “Apache installed succesfully!!!”
            else
                    echo "Something went wrong: Apache did not install"
            fi        
        else
             if [ "$osversion" == 'NAME="Alpine Linux"' ];

            then
                apk add apache2 -y
                if [ $? -eq 0 ]
                then
                        echo “Apache installed succesfully!!!”
                else
                        echo "Something went wrong: Apache did not install"
                fi            
            else
                echo "please contact you system Administrator, This Linux version is not recognized by the script."
            fi
        fi
fi
