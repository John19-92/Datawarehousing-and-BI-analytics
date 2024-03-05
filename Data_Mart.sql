createdb  psql -h localhost -U postgres -p 5432 WasteDB;

CREATE TABLE public."MyDimDate"
(
    dateid integer NOT NULL,
    date date NOT NULL,
    Year integer NOT NULL,
    Quarter integer NOT NULL,
    QuarterName varchar(20) NOT NULL,
    Month integer NOT NULL,
    Monthname varchar(20) NOT NULL,
    Day integer NOT NULL,
    Weekday integer NOT NULL,
    WeekdayName varchar(20) NOT NULL,
    PRIMARY KEY (dateid)
);


CREATE TABLE public."MyDimWaste"
(
    Truckid integer NOT NULL,
    TruckType varchar(40) NOT NULL,
    PRIMARY KEY (Truckid)
);


CREATE TABLE public."MyDimZone"
(
    Stationid integer NOT NULL,
    City character(20) NOT NULL,
    PRIMARY KEY (Stationid)
);

CREATE TABLE public."MyFactTrips"
(
    Tripid integer NOT NULL PRIMARY KEY,
    Dateid integer NOT NULL REFERENCES public."MyDimDate" (dateid),
    Stationid integer NOT NULL REFERENCES public."MyDimZone" (Stationid),
    Truckid integer NOT NULL REFERENCES public."MyDimWaste" (Truckid),
    Wastecollected numeric NOT NULL
);


psql -h localhost -U postgres -p 5432 wastedb < createtables.sql


psql -h localhost -U postgres -p 5432 wastedb < loadDimDate.sql
psql -h localhost -U postgres -p 5432 wastedb < loadDimWaste.sql
psql -h localhost -U postgres -p 5432 wastedb < loadDimZone.sql
psql -h localhost -U postgres -p 5432 wastedb < loadFactTrips.sql

\copy public."MyDimDate" FROM '/home/projects/DimDate.csv' DELIMITER ',' csv header;
select * from public."MyDimDate" limit 5;
\copy public."MyDimWaste" FROM '/home/project/DimTruck.csv' DELIMITER ',' csv header;
select * from public."MyDimWaste" limit 5;
\copy public."MyDimZone" FROM '/home/project/DimStation.csv' DELIMITER ',' csv header;
select * from public."MyDimZone" limit 5;
\copy public."MyFactTrips" FROM '/home/project/FactTrips.csv' DELIMITER ',' csv header;
select * from public."MyFactTrips" limit 5;