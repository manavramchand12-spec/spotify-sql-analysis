 LOAD DATA LOCAL INFILE '/Users/manavn/Downloads/spotify-2023.csv'
INTO TABLE spotify_songs
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

USE spotify_project;

USE spotify_project;

LOAD DATA LOCAL INFILE '/Users/manavn/Downloads/spotify-2023.csv'
INTO TABLE spotify_songs
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*)
FROM spotify_songs;

SELECT *
FROM spotify_songs
LIMIT 10;
-- Q1) Find the top 10 most streamed songs in the Spotify dataset

SELECT track_name, artist_name, streams
FROM spotify_songs
ORDER BY streams DESC
LIMIT 10;

-- Q2) Find the artists with the highest number of songs in the Spotify dataset

SELECT artist_name,
COUNT(*) AS total_songs
FROM spotify_songs
GROUP BY artist_name
ORDER BY total_songs DESC
LIMIT 10;

select * from spotify_songs

-- Q3) Find the average number of streams by release year
   Select released_year , avg(streams) as avg_streams
   from spotify_songs
   group by released_year
   order by released_year;
   
-- Q4) Find the top 10 songs with the highest danceability percentage
     SELECT track_name,
artist_name,
danceability_percent
FROM spotify_songs
ORDER BY danceability_percent DESC
LIMIT 10;

-- Q5) Find the top 10 songs with the highest energy percentage
SELECT track_name,
       artist_name,
       energy_percent
FROM spotify_songs
ORDER BY energy_percent DESC
LIMIT 10;

-- Q6) Find the number of songs released each year

select count(track_name), released_year
from spotify_songs
group by released_year
order by released_year asc;

select * from spotify_songs

-- Q7) Find the artists with the highest total streams across all their songs
SELECT artist_name, sum(streams) as total_streams
from spotify_songs
group by artist_name
order by total_streams desc;

select * from spotify_songs;

-- Q8) Find songs that have above-average streams
SELECT track_name,
       artist_name,
       streams
FROM spotify_songs
WHERE streams > (
       SELECT AVG(streams)
       FROM spotify_songs
)
ORDER BY streams DESC;




-- Q9) Categorize songs as Low, Medium, or High popularity based on stream count
SELECT track_name,
       artist_name,
       streams,
       CASE
            WHEN streams > 1000000000 THEN 'High'
            WHEN streams > 500000000 THEN 'Medium'
            ELSE 'Low'
       END AS popularity
FROM spotify_songs; 

select * from spotify_songs

-- Q10) Compare average streams between Major and Minor mode songs

SELECT mode_type,
       AVG(streams) AS avg_streams
FROM spotify_songs
GROUP BY mode_type
ORDER BY avg_streams DESC;

select * from spotify_songs

-- Q11) Rank songs based on total streams

SELECT track_name,
       artist_name,
       streams,
       RANK() OVER(
            ORDER BY streams DESC
       ) AS stream_ranking
FROM spotify_songs;

-- Q12) Find the highest streamed song for each release year

SELECT track_name,
       released_year,
       streams,
       RANK() OVER(
            PARTITION BY released_year
            ORDER BY streams DESC
       ) AS yearly_rank
FROM spotify_songs;

-- Q13) Find the top 3 most streamed songs for each release year


WITH ranked_songs AS
(
    SELECT track_name,
           artist_name,
           released_year,
           streams,
           RANK() OVER(
                PARTITION BY released_year
                ORDER BY streams DESC
           ) AS yearly_rank
    FROM spotify_songs
)

SELECT track_name,
       artist_name,
       released_year,
       streams,
       yearly_rank
FROM ranked_songs
WHERE yearly_rank <= 3
ORDER BY released_year, yearly_rank;

select * from spotify_songs

-- Q14) Find artists who have more than one highly streamed song

-- Q14) Find artists who have more than one highly streamed song

-- Q14) Find artists who have more than one highly streamed song

SELECT artist_name,
       COUNT(*) AS high_stream_songs
FROM spotify_songs
WHERE streams > 1000000000
GROUP BY artist_name
HAVING COUNT(*) > 1
ORDER BY high_stream_songs DESC;

-- Q15) Find songs that have above-average streams

select track_name, streams
from spotify_songs
where streams > (
   select avg(streams)
   from spotify_songs
)

order by streams desc;

-- Q16) create a view for highly streamed songs
CREATE VIEW high_stream_songs AS
SELECT track_name,
       artist_name,
       streams,
       released_year
FROM spotify_songs
WHERE streams > 1000000000;

SELECT *
FROM high_stream_songs;

-- Q17) Create a stored procedure to find songs by a specific artist

DELIMITER //

CREATE PROCEDURE get_artist_songs(
    IN artist VARCHAR(255)
)
BEGIN

    SELECT track_name,
           artist_name,
           streams
    FROM spotify_songs
    WHERE artist_name = artist;

END //

DELIMITER ;

SELECT *
FROM spotify_songs;













