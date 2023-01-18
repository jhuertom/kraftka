# jhuertom/kraftka
## (A docker version of Kafka Raft)


### How to pull the built image?
docker pull jhuertom/kraftka:latest


### How to build your own image?
Download the newest version of Apache Kafka (https://kafka.apache.org/downloads)
and copy the file to the root of the project.
Replace the dockerfile variable KAFKA_VERSION and SCALA_VERSION with the versions of the file you just downloaded.
Run the docker build command.


### How to configure the cluster?
The cluster is configured by the environment variables in the docker-compose file.
You can run the docker-compose file directly only for testing purposes. If you want to run the cluster in production, please delete the KAFKA_UUID variable.
At the first run withouth the KAFKA_UUID variable, the cluster will be initialized and the KAFKA_UUID variable will be created. You can see the value of the variable in the logs of the first broker.
Please, change the KAFKA_UUID variable in the docker-compose for production purposes.
Running the containers in the same computer is not recommended for production too. You can run the containers in different computers, but you have to change the variables in the docker-compose file.
