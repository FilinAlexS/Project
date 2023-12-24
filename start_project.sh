#!/usr/bin/env bash
echo ---- Create network jenkins ----
docker network create jenkins
echo
echo ---- Start pull images ----
docker pull jenkins/jenkins:2.426.1-jdk17 # macOS can't find the image and stops the process
docker pull selenoid/chrome:120.0
docker pull selenoid/chrome:119.0
docker pull selenoid/firefox:120.0
docker pull selenoid/firefox:119.0
docker pull browsers/safari:15.0
docker pull browsers/safari:14.0
echo
echo ---- Start the build, and then start the necessary images ----
docker compose up --build -d
echo
echo ---- Wait 40 seconds for the Jenkins container to start. Next, let\'s create a job. ----
echo 
sleep 40
echo
echo ---- Create jobs in Jenkins ----
docker exec -it jenkins sh -c "java -jar /usr/share/jenkins/ref/jenkins-cli.jar -s http://localhost:8080/ create-job UI_tests < /usr/share/jenkins/ref/test_ui.xml"
docker exec -it jenkins sh -c "java -jar /usr/share/jenkins/ref/jenkins-cli.jar -s http://localhost:8080/ create-job API_tests < /usr/share/jenkins/ref/test_api.xml"
echo ---- DONE ----
echo
echo ---- NEXT ----
IP=$(ifconfig | grep 'inet 192'| awk '{ print $2}') 
echo ----- 1. Go to http://$IP:8085/manage/configureTools/   -----
echo ----- 2. Check or input in "Allure Commandline" Name \> Allure -----
echo ----- 3. Go to Dashboard/homework and "Build with parameters" -----
echo
