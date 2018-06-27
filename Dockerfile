#Download base image ubuntu 16.04
FROM ubuntu:16.04
 
# Update Software repository
RUN apt-get update
 
RUN apt-get install -y default-jdk
RUN apt-get install wget
RUN apt-get install -y iputils-ping
RUN cd /opt/ && wget https://archive.apache.org/dist/spark/spark-2.2.0/spark-2.2.0-bin-hadoop2.7.tgz

RUN cd /opt/ && tar xzf /opt/spark-2.2.0-bin-hadoop2.7.tgz
RUN ls /opt/

RUN ln -s /opt/spark-2.2.0-bin-hadoop2.7 /spark

RUN mkdir /opt/app

#SPARK
ENV SPARK_HOME=/spark
ENV SPARK_VERSION=2.2.0
ENV HADOOP_VERSION=2.7

COPY app/server_start.sh /opt/app/server_start.sh
COPY app/server_stop.sh /opt/app/server_stop.sh
COPY app/setenv.sh /opt/app/setenv.sh
COPY app/log4j-server.properties /opt/app/log4j-server.properties
COPY app/docker.conf /opt/app/docker.conf
COPY app/settings.sh /opt/app/settings.sh
COPY app/spark-job-server.jar /opt/app/spark-job-server.jar

ENTRYPOINT ["/opt/app/server_start.sh"]

