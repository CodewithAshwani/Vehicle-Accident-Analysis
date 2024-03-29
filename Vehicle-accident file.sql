-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
1. Create table of accident and vrehicle.

CREATE TABLE Accident (
    AccidentIndex VARCHAR(20),
    Severity VARCHAR(10),
    Date DATE,
    Day VARCHAR(10),
    SpeedLimit INT,
    LightConditions VARCHAR(20),
    WeatherConditions VARCHAR(30),
    RoadConditions VARCHAR(20),
    Area VARCHAR(20)
);

CREATE TABLE Vehicle(
    VehicleID VARCHAR(20),
    AccidentIndex VARCHAR(20),
    VehicleType VARCHAR(50),
    PointImpact VARCHAR(20),
    LeftHand VARCHAR(3),
    JourneyPurpose VARCHAR(50),
    Propulsion VARCHAR(20),
    AgeVehicle INT
);


ALTER TABLE public.vehicle
ALTER COLUMN lefthand TYPE VARCHAR(50); -- Adjust the length as needed

ALTER TABLE public.vehicle
ALTER COLUMN pointimpact TYPE VARCHAR(50); -- Adjust the length as needed

select * from accident
select * from vehicle


----------------------------------------------------------------------------------------------------------------------

1. How many accidents have occurred in urbans areas versus rural areas?
																									 
Solution:
SELECT area, COUNT(accidentindex) AS "total accidents"
FROM accident
GROUP BY area;

2. Which day of the week has the highest number of accidents?
																									 
Solution:
SELECT day, COUNT(accidentindex) AS "Total Accidents"
FROM accident
GROUP BY day
ORDER BY "Total Accidents" DESC;

3. What is the average age of vehicle involved in accidents based on their type?
Solution:
																									 
SELECT vehicletype,
       COUNT(accidentindex) AS "Total accident",
       AVG(agevehicle) AS "Average agevehicle"
FROM vehicle
WHERE agevehicle IS NOT NULL
GROUP BY vehicletype
ORDER BY "Total accident" DESC;


4. Can we identify any trends in accidents based on the age of vehicle involved?
Solution:

SELECT agegroup,
       COUNT(accidentindex) AS "Total Accident",
       AVG(agevehicle) AS "Average year"
FROM (
    SELECT 
        accidentindex,
        agevehicle,
        CASE 
            WHEN agevehicle BETWEEN 0 AND 5 THEN 'New'
            WHEN agevehicle BETWEEN 6 AND 10 THEN 'Regular'
            ELSE 'Old'
        END AS agegroup
    FROM vehicle
) AS subquery
GROUP BY agegroup;















5.Are there any specific weather condition that contribute to severe accidents?
Solution:
1.Method
SELECT weatherconditions,
       COUNT(CASE WHEN severity = 'Slight' THEN 1 END) AS "Total Accident"
FROM accident
GROUP BY weatherconditions
ORDER BY "Total Accident" DESC;

2. Method
SELECT WeatherConditions,
       COUNT(WeatherConditions) AS TotalAccident
FROM accident
WHERE Severity = 'Slight'
GROUP BY WeatherConditions
ORDER BY TotalAccident DESC;

6. Do accidents often involve impacts on the left hand side of vehicles?
Solution:
	
1. Method
SELECT lefthand,
       COUNT(accidentindex) AS "Total accident"
FROM vehicle
GROUP BY lefthand
HAVING lefthand IS NOT NULL;

2.Method
SELECT lefthand,
COUNT(accidentindex) AS "Total accident"
FROM vehicle
WHERE lefthand IS NOT NULL
GROUP BY lefthand;
		


																				
7. are there any relationship between journey purposes and the severity of accidents?

Solution:
SELECT Journeypurpose,
       COUNT(severity) AS "Total accident",
       CASE 
           WHEN COUNT(severity) BETWEEN 0 AND 1000 THEN 'low'
           WHEN COUNT(severity) BETWEEN 1001 AND 3000 THEN 'Moderate'
           ELSE 'high'
       END AS "level"
FROM accident
JOIN vehicle ON accident.accidentindex = vehicle.accidentindex
GROUP BY journeypurpose
ORDER BY "Total accident" DESC;

8. Calculate the avergar age of vehicles incolved in accidents,considering day light and point of impact?
Solution:

SELECT lightconditions,
       pointimpact,
       AVG(agevehicle) AS AverageYear
FROM accident
JOIN vehicle ON accident.accidentindex = vehicle.accidentindex
WHERE pointimpact = 'Offside' AND lightconditions = 'Darkness'
GROUP BY lightconditions, pointimpact;





