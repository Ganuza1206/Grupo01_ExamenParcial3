# Grupo01_ExamenParcial3
Resolución del Examen Parcial 3 de Ingeniería de Datos <br>

Descripción del Dataset de la base transaccional del sistema de vuelos Gamatrón <br>

Campo	                            Descripción <br>
Year	                            Año de la fecha de vuelo <br>
Quarter	                            Trimestre de la fecha de vuelo <br>
Month	                            Mes de la fecha de vuelo <br>
DayOfmonth	                        Día del mes de la fecha de vuelo <br>
DayOfWeek	                        Día de la semana de la fecha de vuelo <br>
Flightdate	                        Fecha del vuelo <br>
OperatingAirline	                Código de la aerolínea que opera el vuelo <br>
Flight_Number_Operating_Airline	    Número de vuelo <br>
OriginAirportID	                    Código del aeropuerto de origen <br>
OriginCityName	                    Ciudad del aeropuerto de origen <br>
OriginStateName	                    Estado del aeropuerto de origen <br>
DestAirportID	                    Código del aeropuerto de destino <br>
DestCityName	                    Ciudad del aeropuerto de destino <br>
DestStateName	                    Estado del aeropuerto de destino <br>
CRSDepTime	                        Hora de salida del vuelo programada <br>
DepTime	                            Hora real de salida del vuelo <br>
DepDel15	                        Indicador de retraso en despegue por más de 15 minutos <br>
TaxiOut	                            Tiempo de rodaje antes de despegue en minutos <br>
WheelsOff	                        Hora de despegue de tierra <br>
WheelsOn	                        Hora de aterrizaje en tierra <br>
TaxiIn	                            Tiempo de rodaje después de aterrizaje en minutos <br>
CRSArrTime	                        Hora de aterrizaje programada <br>
ArrTime	                            Hora real de aterrizaje <br>
ArrDel15	                        Indicador de retraso en aterrizaje por más de 15 minutos <br>
Cancelled	                        Indicador si el vuelo fue cancelado <br>
Diverted	                        Indicador si el vuelo fue diferido/desviado <br>
DivAirportLandings	                Cantidad de aterrizajes en aeropuertos para vuelos desviados/diferidos <br>
DivReachedDest	                    Indicador de vuelo diferido/desviado que sí llegó a su destino <br>
DivActualElapsedTime	            Tiempo de vuelo diferido/desviado que sí llegó a su destino en minutos <br>
DivArrDelay	                        Diferencia en minutos entre la hora programada y la hora real de llegada de vuelo diferido/desviado que sí llegó a su destino <br>
DivDistance	                        Distancia en millas del destino de llegada con el destino final de vuelo diferido/desviado <br>
Flights	                            Cantidad de vuelo (1 por defecto) <br>
Distance	                        Distancia en millas recorridas durante el vuelo <br>
CarrierDelay	                    Retraso en minutos debido a la aerolínea <br>
WeatherDelay	                    Retraso en minutos debido al clima <br>
NASDelay	                        Retraso en minutos debido al Sistema Nacional de Espacio Aéreo <br>
SecurityDelay	                    Retraso en minutos debido a seguridad <br>
LateAircraftDelay	                Retraso en minutos debido a la aeronave <br>

## Diseño de la solución para el DataWarehouse <br>

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

Además de todas las ETL para el procesamiento de la data en la herramienta talend, se debe crear una base de datos temporal que <br>
servirá para tratar los SCD. <br>

Pasos: <br>
1. Crear una BD en Microsoft SQL Server llamada: "Grupo01_Parcial3" <br>
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
