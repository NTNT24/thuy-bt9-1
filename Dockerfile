FROM openjdk:24-jdk-slim AS base

# Cài wget + tar
RUN apt-get update && apt-get install -y wget tar && rm -rf /var/lib/apt/lists/*

# Cài Tomcat (sử dụng archive để đảm bảo link ổn định)
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.109/bin/apache-tomcat-9.0.109.tar.gz \
    && tar xzf apache-tomcat-9.0.109.tar.gz \
    && mv apache-tomcat-9.0.109 /usr/local/tomcat \
    && rm apache-tomcat-9.0.109.tar.gz

# Thiết lập biến môi trường
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH="$CATALINA_HOME/bin:$PATH"

# Xóa webapps mặc định và copy war của bạn vào ROOT
RUN rm -rf /usr/local/tomcat/webapps/*
COPY ch09_ex1_download.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
