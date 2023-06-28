FROM openjdk:17

WORKDIR /app
COPY server.jar /app
RUN echo "eula=true" > /app/eula.txt

CMD ["java", "-jar", "server.jar"]
