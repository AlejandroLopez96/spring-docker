# IMAGEN MODELO
FROM eclipse-temurin:17.0.14_7-jdk

# INFORMAR EL PUERTO QUE SE EJECUTA EL CONTENEDOR (INFORMATIVO)
EXPOSE 8080

# DEFINIR DIRECTORIO RAIZ DE NUESTRO CONTENEDOR
WORKDIR /root

# COPIAR Y PEGAR ARCHIVOS DENTRO DEL CONTENEDOR
COPY ./pom.xml /root
COPY ./.mvn /root/.mvn
# Como el contenedor es Linux se mete el mvnw si fuera Windows se debería meter el mvnw.cmd
COPY ./mvnw /root

# DESCARGAR DEPENDENCIAS
RUN ./mvnw dependency:go-offline

# COPIAR EL CODIGO FUENTE
COPY ./src /root/src

# COMPILAR EL PROYECTO (sin test ya que no hay tests en el proyecto)
RUN ./mvnw clean install -DskipTests

# LEVANTAR LA APLICACION CUANDO EL CONTENEDOR INICIE
ENTRYPOINT ["java","-jar","/root/target/SpringDocker-0.0.1-SNAPSHOT.jar"]