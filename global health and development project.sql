--Global Health Development Project


DROP TABLE IF EXISTS GLOBAL_HEALTH;
CREATE TABLE GLOBAL_HEALTH (
    Country VARCHAR(50),
    Country_Code VARCHAR(10),
    Year INT,
    Fertility_Rate DECIMAL(12,3),
    Urban_Population_Percent DECIMAL(12,3),
    Total_Population FLOAT,
    Water_Access_Percent DECIMAL(12,3),
    Unemployment_Rate DECIMAL(12,3),
    Sanitary_Expense_Per_GDP DECIMAL(12,3),
    Life_Expectancy DECIMAL(12,3),
    Life_Expectancy_Female DECIMAL(12,3),
    Life_Expectancy_Male DECIMAL(12,3),
    Infant_Deaths FLOAT,
    GDP_Per_Capita DECIMAL(12,3),
    Hospital_Beds_Per_1000 DECIMAL(12,3),
    Female_Population FLOAT,
    Male_Population FLOAT,
    Alcohol_Consumption_Per_Capita DECIMAL(12,3),
    Immunization_Rate DECIMAL(12,3),
    Sanitary_Expense_Per_Capita DECIMAL(12,3),
    CO2_Exposure_Percent DECIMAL(12,3),
    Air_Pollution DECIMAL(12,3),
    Labour_Force_Total FLOAT,
    Tuberculosis_Per_100000 DECIMAL(12,3),
    Suicide_Rate_Percent DECIMAL(12,3),
    Obesity_Rate_Percent DECIMAL(12,3),
    Underweight_Rate_Percent DECIMAL(12,3),
    Overweight_Rate_Percent DECIMAL(12,3),
    Safe_Water_Access_Percent DECIMAL(12,3)
);

------15 Query Questions for the dataset

--1. List all countries in the dataset
--2. Find the total population of each country in the latest year available.
--3. Identify the country with the highest GDP per capita in 2021.
--4. Calculate the average life expectancy across countries in 2021.
--5. Find countries where infant deaths were fewer than 100 in 2020.
--6. List the top 5 countries with the highest immunization rate in 2021.
--7. Identify the countries with safe water access below 50% in any year.
--8. Find the average CO2 exposure percentage for all countries between 2015 and 2020.
--9. List countries with unemployment rates higher than 20% in 2021.
--10. Determine the total sanitary expenses as a percentage of GDP for each country in 2021.
--11. Compare life expectancy for males and females in each country in 2021.
--12. Find the top 3 countries with the largest improvement in water access percentage from 2012 to 2021.
--13. Determine the correlation between GDP per capita and life expectancy in 2021
--14. Identify countries with obesity rates above 30% and underweight rates below 10% in the same year.
--15. Identity top 10 countries by their overall health index in 2021, calculated as a weighted average of life expectancy, 
--    immunization rate, and safe water access percentage.


--1. List all countries in the dataset
SELECT
DISTINCT COUNTRY
FROM GLOBAL_HEALTH;

--2. Find the total population of each country in the latest year available.
SELECT 
Country, 
MAX(Year) AS Latest_Year, 
Total_Population 
FROM GLOBAL_HEALTH 
GROUP BY COUNTRY,TOTAL_POPULATION
ORDER BY LATEST_YEAR DESC;

--3. Identify the country with the highest GDP per capita in 2021.
SELECT 
Country, 
GDP_Per_Capita 
FROM GLOBAL_HEALTH
WHERE Year = 2021 
AND GDP_Per_Capita IS NOT NULL
ORDER BY GDP_Per_Capita DESC
LIMIT 1;

--4. Calculate the average life expectancy across countries in 2021.
SELECT 
Country, 
AVG(Life_Expectancy) AS Avg_Life_Expectancy
FROM GLOBAL_HEALTH
WHERE Year = 2021
GROUP BY Country
LIMIT 10;

--5. Find countries where infant deaths were fewer than 100 in 2020.
SELECT 
Country, 
Infant_Deaths 
FROM GLOBAL_HEALTH
WHERE Year = 2020 
AND Infant_Deaths < 100
ORDER BY Infant_Deaths ASC;


--6. List the top 5 countries with the highest immunization rate in 2021.
SELECT 
Country, 
Immunization_Rate
FROM GLOBAL_HEALTH
WHERE Year = 2021
AND Immunization_Rate IS NOT NULL
ORDER BY Immunization_Rate DESC
LIMIT 5;

--7. Identify the countries with safe water access below 50% in any year.
SELECT 
DISTINCT Country, 
Year, 
Safe_Water_Access_Percent
FROM GLOBAL_HEALTH
WHERE Safe_Water_Access_Percent < 50;


--8. Find the average CO2 exposure percentage for all countries between 2015 and 2020.
SELECT
Country,
AVG(CO2_Exposure_Percent) AS Avg_CO2_Exposure
FROM GLOBAL_HEALTH
WHERE Year BETWEEN 2015 AND 2020
GROUP BY Country;

--9. List countries with unemployment rates higher than 20% in 2021.
SELECT 
Country, 
Unemployment_Rate
FROM GLOBAL_HEALTH
WHERE Year = 2021 
AND Unemployment_Rate > 20;

--10. Determine the total sanitary expenses as a percentage of GDP for each country in 2021.
SELECT 
Country, 
Sanitary_Expense_Per_GDP
FROM GLOBAL_HEALTH
WHERE Year = 2021
AND Sanitary_Expense_Per_GDP IS NOT NULL
ORDER BY Sanitary_Expense_Per_GDP DESC
LIMIT 5;

--11. Compare life expectancy for males and females in each country in 2021.
SELECT 
Country, 
Life_Expectancy_Female, 
Life_Expectancy_Male, 
(Life_Expectancy_Female - Life_Expectancy_Male) AS Life_Expectancy_Difference
FROM GLOBAL_HEALTH
WHERE Year = 2021
AND Life_Expectancy_Male IS NOT NULL
AND Life_Expectancy_FeMale IS NOT NULL
ORDER BY Life_Expectancy_Difference DESC;

--12. Find the top 3 countries with the largest improvement in water access percentage from 2012 to 2021.
SELECT 
Country, 
MAX(Water_Access_Percent) - MIN(Water_Access_Percent) AS Water_Access_Improvement
FROM GLOBAL_HEALTH
WHERE Year BETWEEN 2012 AND 2021
AND Water_Access_Percent IS NOT NULL
GROUP BY Country
ORDER BY Water_Access_Improvement DESC
LIMIT 3;

--13. Determine the correlation between GDP per capita and life expectancy in 2021
SELECT 
Country,
GDP_Per_Capita, 
Life_Expectancy
FROM GLOBAL_HEALTH
WHERE Year = 2021
AND Life_Expectancy IS NOT NULL
AND GDP_Per_Capita IS NOT NULL
ORDER BY GDP_Per_Capita DESC;

--14. Identify countries with obesity rates above 30% and underweight rates below 10% in the same year.
SELECT 
Country, 
Year, 
Obesity_Rate_Percent, 
Underweight_Rate_Percent
FROM GLOBAL_HEALTH
WHERE Obesity_Rate_Percent > 30 
AND Underweight_Rate_Percent < 10
ORDER BY Year DESC;

--15. Identity top 10 countries by their overall health index in 2021, calculated as a weighted average of life expectancy, 
--    immunization rate, and safe water access percentage.
SELECT 
Country, 
(0.5 * Life_Expectancy + 0.3 * Immunization_Rate + 0.2 * Safe_Water_Access_Percent) AS Health_Index
FROM GLOBAL_HEALTH
WHERE Year = 2021
AND (Life_Expectancy, Immunization_Rate, Safe_Water_Access_Percent) IS NOT NULL
ORDER BY Health_Index DESC
LIMIT 10;


SELECT * FROM GLOBAL_HEALTH;