# Imagen base con Java 17
FROM eclipse-temurin:17-jdk

# Crear directorio de trabajo
WORKDIR /app

# Copiar el .jar compilado desde tu máquina
COPY target/*.jar app.jar

# Exponer el puerto del backend
EXPOSE 8080

# Comando de arranque
ENTRYPOINT ["java", "-jar", "app.jar"]
