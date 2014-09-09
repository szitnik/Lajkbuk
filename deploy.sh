#!/bin/bash
mvn clean
mvn package
sudo service tomcat7 stop
sudo rm -rf /var/lib/tomcat7/webapps/*
sudo cp target/likebook.si.war /var/lib/tomcat7/webapps/ROOT.war
sudo service tomcat7 start
tail -f /var/log/tomcat7/catalina.out
