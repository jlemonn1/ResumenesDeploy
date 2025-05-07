FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copia tu jar compilado
COPY resumenes.jar app.jar

# Activar logs DEBUG y sin límite de memoria
ENTRYPOINT ["java", "-Dlogging.level.root=DEBUG", "-jar", "app.jar"]

EXPOSE 8080
