# Grupo01_ExamenParcial3
Resolución del Examen Parcial 3 de Ingeniería de Datos <br>

Descripción del Dataset de la base transaccional del sistema de vuelos Gamatrón <br>

Year: 	                            Año de la fecha de vuelo <br>
Quarter:	                        Trimestre de la fecha de vuelo <br>
Month:	                            Mes de la fecha de vuelo <br>
DayOfmonth:	                        Día del mes de la fecha de vuelo <br>
DayOfWeek:	                        Día de la semana de la fecha de vuelo <br>
Flightdate:	                        Fecha del vuelo <br>
OperatingAirline:	                Código de la aerolínea que opera el vuelo <br>
Flight_Number_Operating_Airline:	Número de vuelo <br>
OriginAirportID:	                Código del aeropuerto de origen <br>
OriginCityName:	                    Ciudad del aeropuerto de origen <br>
OriginStateName:	                Estado del aeropuerto de origen <br>
DestAirportID:	                    Código del aeropuerto de destino <br>
DestCityName:	                    Ciudad del aeropuerto de destino <br>
DestStateName:	                    Estado del aeropuerto de destino <br>
CRSDepTime:	                        Hora de salida del vuelo programada <br>
DepTime:	                        Hora real de salida del vuelo <br>
DepDel15:	                        Indicador de retraso en despegue por más de 15 minutos <br>
TaxiOut:	                        Tiempo de rodaje antes de despegue en minutos <br>
WheelsOff:	                        Hora de despegue de tierra <br>
WheelsOn:	                        Hora de aterrizaje en tierra <br>
TaxiIn:	                            Tiempo de rodaje después de aterrizaje en minutos <br>
CRSArrTime:	                        Hora de aterrizaje programada <br>
ArrTime:	                        Hora real de aterrizaje <br>
ArrDel15:	                        Indicador de retraso en aterrizaje por más de 15 minutos <br>
Cancelled:	                        Indicador si el vuelo fue cancelado <br>
Diverted:	                        Indicador si el vuelo fue diferido/desviado <br>
DivAirportLandings:	                Cantidad de aterrizajes en aeropuertos para vuelos desviados/diferidos <br>
DivReachedDest:	                    Indicador de vuelo diferido/desviado que sí llegó a su destino <br>
DivActualElapsedTime:	            Tiempo de vuelo diferido/desviado que sí llegó a su destino en minutos <br>
DivArrDelay:	                    Diferencia en minutos entre la hora programada y la hora real de llegada de vuelo diferido/desviado que sí llegó a su destino <br>
DivDistance:	                    Distancia en millas del destino de llegada con el destino final de vuelo diferido/desviado <br>
Flights:	                        Cantidad de vuelo (1 por defecto) <br>
Distance	                        Distancia en millas recorridas durante el vuelo <br>
CarrierDelay:	                    Retraso en minutos debido a la aerolínea <br>
WeatherDelay:	                    Retraso en minutos debido al clima <br>
NASDelay:	                        Retraso en minutos debido al Sistema Nacional de Espacio Aéreo <br>
SecurityDelay:	                    Retraso en minutos debido a seguridad <br>
LateAircraftDelay:	                Retraso en minutos debido a la aeronave <br>

## Diseño de la solución para el DataWarehouse <br>

Al analizar la base de datos transaccional se sigue la metodología de los 4 pasos para crear el modelo del Datawarehouse <br>

1. Proceso de negocio identificado: incidencias de vuelos <br>
2. Nivel de granularidad: <br>
Incidencias de vuelos por día. <br>
Se deben visualizar las incidencias de vuelos (cancelaciones, retrasos y diferidos) en función de las causas del incidente, ya sea retrasos en salidas, llegadas, durante el vuelo, inconvenientes climáticos, técnicos, de seguridad o de aerolínea, por día. <br>
3. Dimensiones: <br>
    DimDate: Tabla de dimensión de fechas. <br>
    DimAirline: Tabla de dimensión de aerolíneas. <br>
    FactFlight: Tabla de hechos de vuelos. <br>

![Diagrama del Datawarehouse](https://github.com/Ganuza1206/Grupo01_ExamenParcial3/blob/main/DiagramaDWImagen.drawio.png)
 <br>
4.	Identificar hechos: <br>
    Métricas: <br>
•	Cantidad de vuelos cancelados en una fecha determinada. <br>
•	Cantidad de vuelos diferidos en una fecha determinada. <br>
•	Cantidad de vuelos retrasados en una fecha determinada. <br>
•	Total de tiempo en retrasos de vuelos en una fecha determinada. <br>
•	Cantidad de vuelos retrasados en una fecha determinada, según sus causas. <br>
•	Total de tiempo en retrasos de vuelos en una fecha determinada, según sus causas. <br>
•	Cantidad de incidencias por vuelo en una fecha determinada. <br>
•	Total de tiempo de las incidencias por vuelo para una fecha determinada. <br>


## Preparación de data en Talend <br>

Todos los datos provenientes de la base de datos transaccional que sean parte del dataset van a ser procesados por medio de la herramienta Talend, 
y almacenados en las locaciones correspondientes en S3 para adecuarlos al Datawarehouse alojado en Redshift. Adicional a dichas operaciones se debe ejecutar el siguiente paso: <br>

### Crear una BD en Microsoft SQL Server llamada: "Grupo01_Parcial3" <br>
Donde se guardará temporalmente la información para asignarle una subrogate Key y los SCD a las respectivas tablas de Dimensión.

Script de la base de datos a ejecutar:

```
create database Grupo01_Parcial3
go

use Grupo01_Parcial3
go

CREATE TABLE dbo.DimDate  
  (dateKey int NOT NULL,
   fullDate varchar(25) NOT NULL,
   dayOfWeek  int NOT NULL,
   dayNumInMonth  int NOT NULL,
   dayNumOverall int NOT NULL,
   dayName varchar(25) NOT NULL,
   dayAbbrev varchar(25) NOT NULL,
   weekdayFlag char(5) NOT NULL,
   weekNumInYear int NOT NULL,
   weekNumOverall  int NOT NULL,
   weekBeginDate varchar(25) NOT NULL,
   weekBeginDateKey int NOT NULL,
   month  int NOT NULL,
   monthNumOverall  int NOT NULL,
   monthName varchar(25) NOT NULL,
   monthAbbrev varchar(25) NOT NULL,
   quarter  int NOT NULL,
   year  int NOT NULL,
   yearmo  int NOT NULL,
   lastDayInMonthFlag char(5) NOT NULL,
   sameDayYearAgo varchar(25) NOT NULL)  
GO 

CREATE TABLE dbo.DimAirline
 (airlineKey int NOT NULL,
  code nvarchar(50) NOT NULL,
  description nvarchar(100) NOT NULL)
GO

```
## Script del Datawarehouse en Redshift <br>

El script generado para redshift es el siguiente: <br>

```

CREATE DATABASE PARCIAL3s3;


CREATE TABLE dimairline(
    airline_key int PRIMARY KEY,
    airline_id Varchar(25),
    code Varchar(50) distkey,
    description Varchar (100)
);

---esta si
CREATE TABLE dimdate (
  date_key int PRIMARY KEY distkey,
  full_date Varchar (25),
  day_of_week int,
  day_num_in_month int,
  day_num_overall int,
  day_name Varchar (25),
  day_abbrev Varchar (25),
  weekday_flag Varchar (1),
  week_num_in_year int,
  week_num_overall int,
  week_begin_date Varchar (25),
  week_begin_date_key int,
  month int,
  month_num_overall int,
  month_name Varchar (25),
  month_abbrev Varchar (25),
  quarter int,
  year int,
  yearmo int,
  last_day_in_month_flag Varchar(5),
  same_day_year_ago Varchar(25)
)sortkey (date_key, month);

CREATE TABLE factflight (
    date_key int DISTKEY,
    airline_key int,
    flight_number varchar(25),
    origin_air_port_id int,
    dest_air_port_id int,
    origin_city_name varchar (100),
    origin_state_name varchar (100),
    dest_city_name varchar (100),
    dest_state_name varchar (100),
    distance_miles int,
    programmed_dep_time int,
    real_dep_time int,
    dep_time_delay int,
    dep_delay_up_15 int,
    dep_delay_description varchar (10),
    taxi_out_time int,
    taxi_out_up_15 varchar (10),
    wheels_off int,
    wheels_on int,
    time_on_air int,
    taxi_in_time int,
    taxi_in_up_15 varchar (10),
    programmed_arr_time int,
    real_arr_time int,
    arr_time_delay int,
    arr_delay_up_15 varchar (10),
    arr_delay_description varchar (10),
    cancelled_info varchar (10),
    diverted_info varchar (10),
    number_diverted_airport_landings int,
    diverted_reached_on_time varchar (10),
    diverted_actual_elapsed_time int,
    diverted_delay int,
    carrier_delay int,
    weather_delay int,
    nas_delay int,
    security_delay int,
    late_air_craft_delay int,
    diverted_distance_miles int,
    flights_qty int,
    total_time_delay int,
    FOREIGN KEY (date_key) REFERENCES dimdate(date_key),
    FOREIGN KEY (airline_key) REFERENCES dimairline(airline_key)
) sortkey (date_key, airline_key);

```

## Visualización de los elementos de AWS (S3 y Redshift) <br>

Toda la data procesada estará situada en S3, dependiendo del estado de procesamiento en que se encuentre puede ubicarse en un bucket ya sea en Raw, Stage o Presentation. <br>
y la base del DataWarehouse estará en Redshift.  <br>

Las credenciales de usuario para visualizar dichos componentes son: <br>
URL: https://717949482576.signin.aws.amazon.com/console <br>
Usuario: parcial3s3 <br>
Contraseña: Parcial3s3 <br>