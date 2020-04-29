FROM adoptopenjdk/openjdk11-openj9:jdk-11.0.7_10_openj9-0.20.0-alpine AS build

COPY . /build
WORKDIR /build

RUN ./mvnw clean package
RUN ls target

FROM adoptopenjdk/openjdk11-openj9:jre-11.0.7_10_openj9-0.20.0-alpine
WORKDIR /root/
COPY --from=build /build/target/demo-0.0.1-SNAPSHOT.jar .
EXPOSE 8080
CMD ["java", "-jar", "demo-0.0.1-SNAPSHOT.jar"]
