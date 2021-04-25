docker run --name jenkins-docker --rm --detach ^
--privileged --network jenkins --network-alias docker ^
--env DOCKER_TLS_CERTDIR=/certs ^
--volume jenkins-docker-certs:/certs/client ^
--volume jenkins-data:/var/jenkins_home ^
docker:dind

docker build -t finalproject-blueocean:1.1 C:\Users\pjkno\OneDrive\Documents\GitHub\cs-491-finalproject

docker run --name jenkins-blueocean --rm --detach ^
--network jenkins --env DOCKER_HOST=tcp://docker:2376 ^
--env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 ^
--volume jenkins-data:/var/jenkins_home ^
--volume jenkins-docker-certs:/certs/client:ro ^
--volume C:\Users\pjkno\OneDrive\:/home ^
--publish 8080:8080 --publish 50000:50000 finalproject-blueocean:1.1