SELECT count(*) FROM drivers;

DESC TABLE drivers;

SELECT COUNT(DISTINCT driver_id) FROM drivers;


SELECT COUNT(distinct driver_id),employment_status 
FROM drivers
GROUP BY employment_status ;

SELECT concat(FIRST_NAME,' ',LAST_NAME) AS FULLNAME, COUNT(DISTINCT driver_id),years_experience
FROM drivers
GROUP BY years_experience,FULLNAME
ORDER BY years_experience DESC;
