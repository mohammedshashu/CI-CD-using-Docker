FROM tomcat:latest

LABEL maintainer="Mohammed Shashu"

ADD ./target/LoginWebApp-1.war /usr/local/tomcat/webapps/

EXPOSE 8084

CMD ["catalina.sh", "run"]
