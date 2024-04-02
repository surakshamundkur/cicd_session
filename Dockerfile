FROM adoptopenjdk:11-jre-hotspot

WORKDIR /app

COPY ./target/classes/Main.class /app

EXPOSE 9000

CMD ["java", "Main"]
