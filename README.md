# Guía de uso

## Prerequisitos

Se requiere tener instalados los siguientes programas:

- Excel
- MySQL
- Pentaho
- PowerBI

## Busqueda Dataset

Se realiza la busqueda del dataset a usar para la migración desde un archivo de excel hacia una base de datos en MySQL. Para la realización del ejercicio se selecciono los candidatos definitivos para las elecciones del 2023 en Colombia.

>***Nota:*** Dentro del archivo `CANDIDATOS_DEFINITIVO_ELECCIONES_2023.xlsx` se encuentra este proceso

## Limpieza De Datos En El Dataset

Una vez conseguido el Dataset, se realiza una limpieza en cuanto a algunos caracteres especificos que no son soportados en el SGBD como pueden ser los puntos o las comas en los valores tipo entero. En el caso de la base de datos se hace uso de una configuración de caracteres utf-8 el cual soporta caracteres especiales en español tales como la ñ o las vocales con tildes.

>***Nota:*** Dentro del archivo `CANDIDATOS_DEFINITIVO_ELECCIONES_2023-LIMPIO.xlsx` se encuentra este proceso

## Creación Base de Datos

Realizada la limpieza, se crea una base de datos con la cual vamos a trabajar. Una vez creada se realiza los siguientes procedimientos:

- ### Creación de Tabla Temporal

Se crean una tabla temporal para almacenar todos los datos que nos brinda el excel e interactuar con ellos para la gestión de carga en otras tablas ya normalizadas.

- ### Normalización Tabla Temporal

Se normaliza la tabla temporal para ya contar con un sistema transaccional para los datos y cumplir con los principios ACID.

- ### Creación de las Tablas Dimensiones

Una vez normalizada creamos las tablas independientes identificadas en el sistema, las cuales llamaremos tablas dimensiones.

- ### Creación de la Tabla de Hechos

Ya creadas las tablas dimencionales, se crean la tabla de hechos que es la tabla central, la cual esta relacionada con todas las tablas dimensiones.

>***Nota:*** Dentro del archivo `script.sql` se encuentra este proceso

## Implementacion del ETL en Pentaho

Con la base de datos ya creada, iniciamos con la creación del job a realizar para la extraccion, transformacion y limpieza de los datos. Para ello se necesitan de diferentes transformaciones dentro del job:

- ### Limpiar Tablas

Se vacian todas las tablas del sistema transaccional para tenerlas lo mas limpias posibles, lo ideal es que esten virgenes.

>***Nota:*** Esta transformación se encuentra en el archivo `00_LimpiarTablas.ktr`

- ### Cargar Datos En la Tabla Temporal

Se leen todos los datos que se encuentran en el excel ya limpio, para luego cargarlos en la tabla temporal creada en el SGBD, la cual llamares como tabla o área de staging.

>***Nota:*** Esta transformación se encuentra en el archivo `10_CargarDatosStaging.ktr`

- ### Limpiar Datos Staging

Ya cargados los datos en la tabla staging, los limpiamos para tener toda la informacion necesaria para posteriormente realizarle analitica de negocio.

>***Nota:*** Esta transformación se encuentra en el archivo `11_LimpiarDatosStaging.ktr`

- ### Cargar Datos Tablas Dimensiones

Una vez limpios los datos, los cargaremos en las tablas dimensiones. Cabe destacar que primero se cargan los datos en estas tablas ya que son independientes, por lo que no necesitan datos de otras tablas.

>***Nota:*** Esta transformación se encuentra en el archivo `20_CargarDatosTablasDimensiones.ktr`

- ### Cargar Datos Tablas de Hechos

Ya cargados los datos en las tablas dimensiones, guardamos los datos necesarios para la tabla de hechos y creamos las relaciones con las tablas dimensiones.

>***Nota:*** Esta transformación se encuentra en el archivo `30_CargarDatosTablaHecho.ktr`

Ya una vez completada la creacion y configuracion de las transformaciones, podremos ejecutarlas en nuestro job. Al finalizar la ejecucion, toda la informacion del excel inicial estara dentro de nuestro sistema transaccional normalizado.

>***Nota:*** Este job se encuentra en el archivo `J_ProcesarDatos.ktr`

## Conectar El Sistema Transaccional Con PowerBI

Con nuestro sistema completo, podremos realizar la analitica de negocio dentro de PowerBI realizando la conexion.

>***Nota:*** Se puede encontrar un dashboard en el archivo `dashboard.pbix`
