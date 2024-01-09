-- Q1: Who is the senior most employee based on job title? 

SELECT *
FROM employee
ORDER BY levels desc
LIMIT 1



-- Q2: Which countries have the most Invoices?

SELECT count(*) AS c, billing_country
FROM invoice
GROUP BY billing_country
ORDER BY c desc



-- Q3: What are top 3 values of total invoice?

SELECT total
FROM invoice
ORDER BY total desc
LIMIT 3



/* Q4: Which city has the best customers? We would like to throw a promotional
       Music Festival in the city we made the most money. 
       Write a query that returns one city that has the highest sum of 
	   invoice totals. 
       Return both the city name & sum of all invoice totals */
   
SELECT SUM(total) AS invoice_total, billing_city
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total desc



/* Q5: Who is the best customer? The customer who has spent the most money will 
       be declared the best customer. 
       Write a query that returns the person who has spent the most money.*/

SELECT c.customer_id, c.first_name, c.last_name,sum(i.total) AS total
FROM customer AS c
JOIN invoice AS i
ON c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY total desc
LIMIT 1


/* Question Set 2 - Moderate */

/* Q1: Write query to return the email, first name, last name, & Genre of 
       all Rock Music listeners. 
       Return your list ordered alphabetically by email starting with A. */
-- Solution 1
SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id
	FROM track
	JOIN genre 
	ON track.genre_id = genre.genre_id
	WHERE genre.name like 'Rock')
ORDER BY email;

-- Solution 2
SELECT DISTINCT email AS Email,first_name AS FirstName, last_name AS LastName, genre.name AS Name
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email;



/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */
SELECT artist.artist_id, artist.name, count(artist.artist_id) AS NumberOfSong
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY NumberOfSong DESC
LIMIT 10;



/* Q3: Return all the track names that have a song length longer than the average song length. 
       Return the Name and Milliseconds for each track. Order by the song length with
       the longest songs listed first. */
	
SELECT name,milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track)
ORDER BY milliseconds DESC;

/* Question Set 3 - Advance */

/* Q1: Find how much amount spent by each customer on artists? Write a query to return customer name,
       artist name and total spent */
WITH best_selling_artist AS(
	SELECT artist.artist_id AS artist_id, artist.name AS artist_name,
	  SUM(invoice_line.unit_price * invoice_line.quantity) AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY artist.artist_id
	ORDER BY total_sales DESC
	LIMIT 1
)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, 
   SUM(il.quantity * il.unit_price)AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC



/* Q2: We want to find out the most popular music Genre for each country. 
	   We determine the most popular genre as the genre 
       with the highest amount of purchases. Write a query that returns each country along with the 
	   top Genre. For countries where the maximum number of purchases is shared return all Genres. */
WITH popular_genre AS (
	SELECT COUNT(il.quantity) AS purchase, c.country, g.name, g.genre_id,
	ROW_NUMBER() OVER(PARTITION BY c.country ORDER BY COUNT(il.quantity) DESC) AS row_no
	FROM invoice_line il
	JOIN invoice i ON i.invoice_id = il.invoice_id
	JOIN customer c On c.customer_id = i.customer_id
	JOIN track t ON t.track_id = il.track_id
	JOIN genre g On g.genre_id = t.genre_id
	GROUP BY c.country, g.name, g.genre_id
	ORDER BY c.country, 1 DESC
	)
SELECT * FROM popular_genre WHERE row_no <= 1;



/* Q3: Write a query that determines the customer that has spent the most on music for each country. 
       Write a query that returns the country along with the top customer and how much they spent. 
       For countries where the top amount spent is shared, provide all customers who spent 
	   this amount. */
	   
WITH Customer_with_country AS(
	SELECT c.customer_id, c.first_name, c.last_name, i.billing_country, SUM(total) AS total_spending,
	ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS row_no
	FROM invoice i
	JOIN customer c ON c.customer_id = i.customer_id
	GROUP BY c.customer_id, first_name, last_name, billing_country
	ORDER BY billing_country, total_spending DESC)
SELECT * FROM Customer_with_country WHERE row_no <= 1;





