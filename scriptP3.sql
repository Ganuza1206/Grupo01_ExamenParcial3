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
