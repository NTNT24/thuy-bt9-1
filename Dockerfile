FROM openjdk:24-jdk-slim AS base

# Cài wget + tar
RUN apt-get update && apt-get install -y wget tar && rm -rf /var/lib/apt/lists/*

# Cài Tomcat 
RUN wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.109/bin/apache-tomcat-9.0.109.tar.gz \
    && tar xzf apache-tomcat-9.0.109.tar.gz \
    && mv apache-tomcat-9.0.109 /usr/local/tomcat \
    && rm apache-tomcat-9.0.109.tar.gz


ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH="$CATALINA_HOME/bin:$PATH"

# Copy war vào Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*
COPY ch09_ex1_download.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]

