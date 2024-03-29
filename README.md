**For Project Setup:**
1. https://www.youtube.com/watch?v=4HJwrXclC3A (backup restore postgreSQL  database in pgadmin 4 postgreSQL tutorial explained)
2. https://www.youtube.com/watch?v=9PxaTPZIYmc (Import Excel/CSV file data into Postgresql database table pgAdmin 4)

--------------------------------------------------------------------------------------------------------------------------------------------
**Index**

**1. Project
2. Introduction
3. Process/Procedure
4. Objectives
5. Methodology
6. Data Analysis
7. Conclusion**

--------------------------------------------------------------------------------------------------------------------------------------------

**1. Title:** Exploratory Data Analysis of Accidents: Understanding Trends and Patterns

**2. Introduction:**
The project aims to conduct exploratory data analysis (EDA) on an accident database using PostgreSQL through PhpMyAdmin. 
The dataset contains comprehensive information regarding various aspects of accidents, including location (urban or rural), day of the week, vehicle types, weather conditions, 
impact points, journey purposes, and severity. 
By analyzing this dataset, we aim to uncover insights into accident patterns, contributing factors, and potential correlations between different variables.

**3.Objectives:**
1. Analyze the distribution of accidents in urban areas versus rural areas.
2. Determine which day of the week experiences the highest number of accidents.
3. Investigate the average age of vehicles involved in accidents based on their types.
4. Explore trends in accidents concerning the age of vehicles involved.
5. Identify specific weather conditions that contribute to severe accidents.
6. Investigate whether accidents often involve impacts on the left-hand side of vehicles.
7. Determine if there is any relationship between journey purposes and the severity of accidents.
8. Calculate the average age of vehicles involved in accidents considering daylight and point of impact. 

**4. Process/Procedure**
1. Firstly you have to make a database  name as Vehicle-Accident 
2. after that db(Vehicle-Accident) in that db ,i have to create  a backup file name as vehiclebackup(which is stored as a Documents folder end. 
3. after that i have yo create a new database  which i given name as (Vehicle-Accident New). 
4. after that i have to restore the vehiclebackup file.
5. after that there is no error and the database is created Vehicle-Accident database and i have working on the Vehicle-Accident.
6. now we have to create new table such as accident and vehicle. and after create the table i have to import the cs files and give and check the  "general", "options", "columns".
7. after that we import the accident .csv files from accident table and it working fine.
8. after that we have to import the vehicle.csv file from the vehicle table.

**5. Methodology:**
The project involves executing a series of PostgreSQL queries on the accident database to extract relevant information for each objective.
We start with simple queries and gradually progress to more complex ones to address the different research questions. 
PhpMyAdmin provides a user-friendly interface for executing SQL queries and visualizing query results, facilitating the EDA process.

**6. Data Analysis:**
1. Urban vs. Rural Accidents: Compare the count of accidents in urban and rural areas.
2. Day of the Week Analysis: Determine the frequency of accidents on each day of the week.
3. Average Age of Vehicles: Calculate the average age of vehicles involved in accidents, categorized by vehicle types.
4. Trends in Accident Age: Explore trends in accidents based on the age of vehicles involved.
5. Weather Condition Analysis: Identify weather conditions associated with severe accidents.
6. Impact Point Analysis: Investigate the prevalence of left-hand side impacts in accidents.
7. Journey Purpose vs. Severity: Analyze the relationship between journey purposes and accident severity.
8. Daylight and Impact Analysis: Calculate the average age of vehicles involved in accidents based on daylight and impact point.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
**1. Create table of accident and vrehicle.**

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

**1. How many accidents have occurred in urbans areas versus rural areas?**
																									 
Solution:
SELECT area, COUNT(accidentindex) AS "total accidents"
FROM accident
GROUP BY area;
fOUTPUT File:
<img width="431" alt="1" src="https://github.com/CodewithAshwani/Vehicle-Accident-Analysis/assets/73930456/e385f97d-aa13-49e7-969b-5738ac7c087d">

**2. Which day of the week has the highest number of accidents?**
																									 
Solution:
SELECT day, COUNT(accidentindex) AS "Total Accidents"
FROM accident
GROUP BY day
ORDER BY "Total Accidents" DESC;
Output File:
<img width="463" alt="2" src="https://github.com/CodewithAshwani/Vehicle-Accident-Analysis/assets/73930456/3a0a4f4f-da72-4056-b57c-88fc462dc5ce">

**3. What is the average age of vehicle involved in accidents based on their type?**

Solution:																								 
SELECT vehicletype,
       COUNT(accidentindex) AS "Total accident",
       AVG(agevehicle) AS "Average agevehicle"
FROM vehicle
WHERE agevehicle IS NOT NULL
GROUP BY vehicletype
ORDER BY "Total accident" DESC;
Output File:
<img width="598" alt="3" src="https://github.com/CodewithAshwani/Vehicle-Accident-Analysis/assets/73930456/1e5acb72-b07b-49c8-969f-83c6c5535ba1">

**4. Can we identify any trends in accidents based on the age of vehicle involved?**

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
Output File:
<img width="427" alt="4" src="https://github.com/CodewithAshwani/Vehicle-Accident-Analysis/assets/73930456/be03a2a6-c3bf-4595-b5b9-c3ae2e7c115f">


**5.Are there any specific weather condition that contribute to severe accidents?**

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

Output File:
<img width="647" alt="5" src="https://github.com/CodewithAshwani/Vehicle-Accident-Analysis/assets/73930456/d776a5b8-737e-4e63-a92b-77651551d6c4">

**6. Do accidents often involve impacts on the left hand side of vehicles?**
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

Output File:
<img width="482" alt="6" src="https://github.com/CodewithAshwani/Vehicle-Accident-Analysis/assets/73930456/96b76589-e71b-4fec-8db3-d3bca8a16f31">
																					
**7. are there any relationship between journey purposes and the severity of accidents?**
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

Output File:
<img width="602" alt="7" src="https://github.com/CodewithAshwani/Vehicle-Accident-Analysis/assets/73930456/6c1c8252-54a2-4752-aec3-aa5e8065198c">


******8. Calculate the avergar age of vehicles incolved in accidents,considering day light and point of impact?**
Solution:

SELECT lightconditions,
       pointimpact,
       AVG(agevehicle) AS AverageYear
FROM accident
JOIN vehicle ON accident.accidentindex = vehicle.accidentindex
WHERE pointimpact = 'Offside' AND lightconditions = 'Darkness'
GROUP BY lightconditions, pointimpact;

Output File:
<img width="759" alt="8" src="https://github.com/CodewithAshwani/Vehicle-Accident-Analysis/assets/73930456/ada0f06b-85bd-4a81-8173-5df0bc2dec80">


**Conclusion:**

Through comprehensive data analysis, we aim to gain valuable insights into accident patterns and contributing factors. 
By addressing the research questions, we can better understand the dynamics of accidents and potentially identify areas for intervention and improvement in road safety measures. 
The project highlights the importance of data-driven approaches in accident analysis and lays the foundation for further research and decision-making processes.




