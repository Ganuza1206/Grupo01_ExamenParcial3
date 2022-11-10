# Grupo01_ExamenParcial3
Resolución del Examen Parcial 3 de Ingeniería de Datos

Descripción del Dataset de la base transaccional del sistema de vuelos Gamatrón

Campo	                        Descripción
Year	                            Año de la fecha de vuelo
Quarter	                            Trimestre de la fecha de vuelo
Month	                            Mes de la fecha de vuelo
DayOfmonth	                        Día del mes de la fecha de vuelo
DayOfWeek	                        Día de la semana de la fecha de vuelo
Flightdate	                        Fecha del vuelo
OperatingAirline	                Código de la aerolínea que opera el vuelo
Flight_Number_Operating_Airline	    Número de vuelo
OriginAirportID	                    Código del aeropuerto de origen
OriginCityName	                    Ciudad del aeropuerto de origen
OriginStateName	                    Estado del aeropuerto de origen
DestAirportID	                    Código del aeropuerto de destino
DestCityName	                    Ciudad del aeropuerto de destino
DestStateName	                    Estado del aeropuerto de destino
CRSDepTime	                        Hora de salida del vuelo programada
DepTime	                            Hora real de salida del vuelo
DepDel15	                        Indicador de retraso en despegue por más de 15 minutos
TaxiOut	                            Tiempo de rodaje antes de despegue en minutos
WheelsOff	                        Hora de despegue de tierra
WheelsOn	                        Hora de aterrizaje en tierra
TaxiIn	                            Tiempo de rodaje después de aterrizaje en minutos
CRSArrTime	                        Hora de aterrizaje programada
ArrTime	                            Hora real de aterrizaje
ArrDel15	                        Indicador de retraso en aterrizaje por más de 15 minutos
Cancelled	                        Indicador si el vuelo fue cancelado
Diverted	                        Indicador si el vuelo fue diferido/desviado
DivAirportLandings	                Cantidad de aterrizajes en aeropuertos para vuelos desviados/diferidos
DivReachedDest	                    Indicador de vuelo diferido/desviado que sí llegó a su destino
DivActualElapsedTime	            Tiempo de vuelo diferido/desviado que sí llegó a su destino en minutos
DivArrDelay	                        Diferencia en minutos entre la hora programada y la hora real de llegada de vuelo diferido/desviado que sí llegó a su destino
DivDistance	                        Distancia en millas del destino de llegada con el destino final de vuelo diferido/desviado
Flights	                            Cantidad de vuelo (1 por defecto)
Distance	                        Distancia en millas recorridas durante el vuelo
CarrierDelay	                    Retraso en minutos debido a la aerolínea
WeatherDelay	                    Retraso en minutos debido al clima
NASDelay	                        Retraso en minutos debido al Sistema Nacional de Espacio Aéreo
SecurityDelay	                    Retraso en minutos debido a seguridad
LateAircraftDelay	                Retraso en minutos debido a la aeronave

## Diseño de la solución para el DataWarehouse

1. Proceso de negocio identificado: incidencias de vuelos
2. Nivel de granularidad:
Incidencias de vuelos por día.
Se deben visualizar las incidencias de vuelos (cancelaciones, retrasos y diferidos) en función de las causas del incidente, ya sea retrasos en salidas, llegadas, durante el vuelo, inconvenientes climáticos, técnicos, de seguridad o de aerolínea, por día.
3. Dimensiones:
    DimDate: Tabla de dimensión de fechas. <br>
    DimAirline: Tabla de dimensión de aerolíneas. <br>
    FactFlight: Tabla de hechos de vuelos. <br>

![Diagrama del Datawarehouse](https://github.com/Ganuza1206/Grupo01_ExamenParcial3/blob/main/DiagramaDWImagen.drawio.png)

4.	Identificar hechos:
    Métricas:
•	Cantidad de vuelos cancelados en una fecha determinada.
•	Cantidad de vuelos diferidos en una fecha determinada.
•	Cantidad de vuelos retrasados en una fecha determinada.
•	Total de tiempo en retrasos de vuelos en una fecha determinada
•	Cantidad de vuelos retrasados en una fecha determinada, según sus causas.
•	Total de tiempo en retrasos de vuelos en una fecha determinada, según sus causas.
•	Cantidad de incidencias por vuelo en una fecha determinada.
•	Total de tiempo de las incidencias por vuelo para una fecha determinada.
