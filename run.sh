docker rm jenkins
docker build . --tag jendocker && \
docker run --publish 8000:8080 --name jenkins -v jenkinsdata:/var/jenkins_home jendocker