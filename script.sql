CREATE DATABASE IF NOT EXISTS elecciones2023;
USE elecciones2023;

/*
 Tabla de stagging
 */
 CREATE TABLE IF NOT EXISTS elecciones_stg(
	id_registro INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    cargo VARCHAR(50),
    circunscripcion VARCHAR(20),
    departamento VARCHAR(30),
    municipio VARCHAR(50),
    localidad VARCHAR(100),
    opcion_voto VARCHAR(20),
    tipo_agrupacion_politica VARCHAR(100),
    codigo_agrupacion_politica INT,
    nombre_agrupacion_politica VARCHAR(100),
    renglon INT,
    cedula_candidato BIGINT,
    primer_nombre_candidato VARCHAR(50),
    segundo_nombre_candidato VARCHAR(50),
    primer_apellido_candidato VARCHAR(50),
    segundo_apellido_candidato VARCHAR(50),
    genero VARCHAR(50)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
 
/*
TABLAS DE DIMENSIÓN
*/
CREATE TABLE IF NOT EXISTS cargo(
	id_cargo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cargo VARCHAR(50)
 );

 CREATE TABLE IF NOT EXISTS genero(
	id_genero INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    genero VARCHAR(50)
 );
 
 CREATE TABLE IF NOT EXISTS agrupacion_politica(
	id_agrupacion_politica INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tipo_agrupacion_politica VARCHAR(100),
    codigo_agrupacion_politica INT,
    nombre_agrupacion_politica VARCHAR(100)
 );
 
  CREATE TABLE IF NOT EXISTS opcion_voto(
	id_opcion_voto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    opcion_voto VARCHAR(20)
 );
 
  CREATE TABLE IF NOT EXISTS departamento(
	id_departamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombre_departamento VARCHAR(30)
 );
 
  CREATE TABLE IF NOT EXISTS municipio(
	id_municipio INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombre_municipio VARCHAR(50)
 );
 
  CREATE TABLE IF NOT EXISTS localidad(
	id_localidad INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombre_localidad VARCHAR(100)
 );
 
 CREATE TABLE IF NOT EXISTS circunscripcion(
	id_circunscripcion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    circunscripcion VARCHAR(20)
 );
 
 /*
 TABLA DE HECHOS
*/
CREATE TABLE IF NOT EXISTS candidato(
	id_candidato INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cedula_candidato BIGINT,
    primer_nombre_candidato VARCHAR(50),
    segundo_nombre_candidato VARCHAR(50),
    primer_apellido_candidato VARCHAR(50),
    segundo_apellido_candidato VARCHAR(50),
    renglon INT,
    id_cargo INT,
    id_genero INT,
    id_agrupacion_politica INT,
    id_opcion_voto INT,
    id_departamento INT,
    id_municipio INT,
    id_localidad INT,
    id_circunscripcion INT
);

/*
Desarrollar relaciones
*/
ALTER TABLE candidato ADD CONSTRAINT FK_CandidatoCargo FOREIGN KEY candidato(id_cargo) REFERENCES cargo(id_cargo);
ALTER TABLE candidato ADD CONSTRAINT FK_CandidatoGenero FOREIGN KEY candidato(id_genero) REFERENCES genero(id_genero);
ALTER TABLE candidato ADD CONSTRAINT FK_CandidatoAgrupacionPolitica FOREIGN KEY candidato(id_agrupacion_politica) REFERENCES agrupacion_politica(id_agrupacion_politica);
ALTER TABLE candidato ADD CONSTRAINT FK_CandidatoOpcionVoto FOREIGN KEY candidato(id_opcion_voto) REFERENCES opcion_voto(id_opcion_voto);
ALTER TABLE candidato ADD CONSTRAINT FK_CandidatoDepartamento FOREIGN KEY candidato(id_departamento) REFERENCES departamento(id_departamento);
ALTER TABLE candidato ADD CONSTRAINT FK_CandidatoMunicipio FOREIGN KEY candidato(id_municipio) REFERENCES municipio(id_municipio);
ALTER TABLE candidato ADD CONSTRAINT FK_CandidatoLocalidad FOREIGN KEY candidato(id_localidad) REFERENCES localidad(id_localidad);
ALTER TABLE candidato ADD CONSTRAINT FK_CandidatoCircunscripcion FOREIGN KEY candidato(id_circunscripcion) REFERENCES circunscripcion(id_circunscripcion);