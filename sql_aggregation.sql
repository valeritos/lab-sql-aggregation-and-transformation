#SAKILA SCHEMA WAS SELECTED AS DEFAULT, SO ALL TABLES ARE RUN FROM THERE UNLESS STATED OTHERWISE IN THE FROM CLAUSE
#CHALLENGE 1

#1.1 shortest and longest movie durations
SELECT MAX(LENGTH) AS max_duration, MIN(LENGTH) AS min_duration FROM FILM;
#1.2 average movie duration in hours and minutes
SELECT CONCAT(FLOOR(AVG(LENGTH)/60),"h",round(avg(length)%60,0),"m") FROM FILM;

#2.1
#Calculate the number of days that the company has been operating.
SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) as operation FROM rental;

#2.2
#Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, MONTH(rental_date) AS rent_month, DAYNAME(rental_date) AS rent_day FROM rental
LIMIT 20;

#2.3
#Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
SELECT *, MONTH(rental_date) AS rent_month, DAYNAME(rental_date) AS rent_day,
CASE WHEN DAYNAME(rental_date) in ("Saturday","Sunday") THEN "weekend" ELSE "workday" END AS day_type FROM rental;

#3
#Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT DISTINCT title, IFNULL(rental_duration,"Not Available") as rental_duration FROM film
ORDER BY title ASC;

#4
SELECT CONCAT(first_name," ",last_name) as customer_name, SUBSTRING(email,1,3) as email_3, email FROM customer;

#CHALLENGE 2

#1.1 The total number of films that have been released.
SELECT COUNT(*) AS n_films FROM FILM;
#1.2 The number of films for each rating.
SELECT DISTINCT rating, COUNT(film_id) as n_films FROM film GROUP BY rating;
#1.3 The number of films for each rating, sorting desc
SELECT DISTINCT rating, COUNT(film_id) as n_films FROM film GROUP BY rating ORDER BY COUNT(film_id) DESC;

#2.1 mean film duration for each rating, and sort the results in descending order of the mean
SELECT DISTINCT rating, ROUND(AVG(length),2) as mean_duration FROM film GROUP BY rating ORDER BY AVG(length) DESC;
#2.2 which ratings have a mean duration of over two hours
SELECT * FROM 
(SELECT DISTINCT rating, ROUND(AVG(length),2) as mean_duration FROM film GROUP BY rating ORDER BY AVG(length) DESC) m
WHERE m.mean_duration>120;

#3
#determine which last names are not repeated in the table actor
SELECT * FROM
(SELECT DISTINCT last_name, COUNT(last_name) as name_count FROM actor GROUP BY last_name) m
WHERE m.name_count=1;

