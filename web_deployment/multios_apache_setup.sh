#!/bin/bash

# Variable Declaration
#ART_NAME='2137_barista_cafe'
URL='https://www.tooplate.com/zip-templates/2137_barista_cafe.zip'
TEMPDIR="/tmp/webfiles"
DESTDIR="/var/www/html/"

yum --help &> /dev/null

if [ $? -eq 0 ]
then
    # Set Variables for CentOS
    PACKAGE="httpd wget unzip"
    SVC="httpd"

    echo "Running Setup on CentOS"
    echo "########################################"
    echo "Installing packages."
    echo "########################################"
    yum install $PACKAGE -y > /dev/null
    echo

    echo "########################################"
    echo "Start & Enable HTTPD Service"
    echo "########################################"
    systemctl start $SVC
    systemctl enable $SVC
    echo

    # Creating Temp Directory
    echo "########################################"
    echo "Starting Artifact Deployment"
    echo "########################################"
    mkdir -p $TEMPDIR
    echo

    wget -O $TEMPDIR/webpage.zip $URL
    unzip $TEMPDIR/webpage.zip -d $TEMPDIR
    mv $TEMPDIR/*/* $TEMPDIR
    cp -r $TEMPDIR/* $DESTDIR
    echo

    echo "########################################"
    echo "Restarting HTTPD service"
    echo "########################################"
    systemctl restart $SVC
    echo

    echo "########################################"
    echo "Removing Temporary Files"
    echo "########################################"
    rm -rf $TEMPDIR
    echo

    echo "########################################"
    echo "activating port 80 - TCP"
    firewall-cmd --zone=public --add-port=80/tcp --permanent
    firewall-cmd --reload
    echo "########################################"

    # systemctl status $SVC
    ls -la /var/www/html/
    
    echo "########################################"
    echo Installation complete! your ip-address is:
    hostname -I
    echo
else
    # Set Variables for Ubuntu
    PACKAGE="apache2 wget unzip"
    SVC="apache2"

    echo "Running Setup on CentOS"
    # Installing Dependencies
    echo "########################################"
    echo "Installing packages."
    echo "########################################"
    apt update
    apt install $PACKAGE -y > /dev/null
    echo

    # Start & Enable Service
    echo "########################################"
    echo "Start & Enable HTTPD Service"
    echo "########################################"
    systemctl start $SVC
    systemctl enable $SVC
    echo

    # Creating Temp Directory
    echo "########################################"
    echo "Starting Artifact Deployment"
    echo "########################################"
    mkdir -p $TEMPDIR
    echo

    wget -O $TEMPDIR/webpage.zip $URL
    unzip $TEMPDIR/webpage.zip -d $TEMPDIR
    mv $TEMPDIR/*/* $TEMPDIR
    cp -r $TEMPDIR/* $DESTDIR
    echo

    # Bounce Service
    echo "########################################"
    echo "Restarting HTTPD service"
    echo "########################################"
    systemctl restart $SVC
    echo

    # Clean Up
    echo "########################################"
    echo "Removing Temporary Files"
    echo "########################################"
    rm -rf $TEMPDIR
    echo

    echo "########################################"
    echo "activating port 80 - TCP"
    ufw allow 80/tcp
    echo "########################################"

    # systemctl status $SVC
    ls /var/www/html/

    echo "########################################"
    echo Installation complete! your ip-address is:
    hostname -I
    echo
fi
