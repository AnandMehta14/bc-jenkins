FROM tomcat

EXPOSE 8080

COPY target/java-web-app*.war /usr/local/tomcat/webapps/java-web-app.war
