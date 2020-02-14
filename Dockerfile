FROM openjdk:8-jre-slim

VOLUME /tmp
ARG JAR_FILE=samplesvc*.jar
RUN apt-get update
RUN apt-get -yq install curl
RUN apt-get -yq clean
COPY target/$JAR_FILE /opt/samplesvc.jar
RUN mkdir liquibase
COPY target/jars/liquibase.jar /liquibase/liquibase.jar
COPY target/jars/postgres.jar /liquibase/postgres.jar
COPY target/jars/snakeyaml.jar /usr/local/openjdk-8/lib/ext/snakeyaml.jar
COPY src/main/resources/database /liquibase/database
COPY src/main/resources/liquibase.properties /liquibase

ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar /opt/samplesvc.jar" ]
