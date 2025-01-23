# Y3






mysql -u root -p


CREATE DATABASE yts;
GRANT ALL PRIVILEGES ON yts.* TO 'root'@'localhost' IDENTIFIED BY '123';
FLUSH PRIVILEGES;




CREATE TABLE movies (
  id INT AUTO_INCREMENT PRIMARY KEY,
  movie_id INT,
  movie_json JSON
);



CREATE TABLE movies1 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  movie_id INT,
  movie_json JSON
);



INSERT INTO movies (movie_id, movie_json)
VALUES
(66200, '{
  "id": 66200,
  "url": "https://yts.mx/movies/amazing-grace-1974",
  "imdb_code": "tt0071130",
  "title": "Amazing Grace",
  "title_english": "Amazing Grace",
  "title_long": "Amazing Grace (1974)",
  "slug": "amazing-grace-1974",
  "year": 1974,
  "rating": 5.7,
  "runtime": 99,
  "genres": [
    "Comedy"
  ],
  "summary": "",
  "description_full": "",
  "synopsis": "",
  "yt_trailer_code": "6ITcduhWxAo",
  "language": "en",
  "mpa_rating": "",
  "background_image": "https://yts.mx/assets/images/movies/amazing_grace_1974/background.jpg",
  "background_image_original": "https://yts.mx/assets/images/movies/amazing_grace_1974/background.jpg",
  "small_cover_image": "https://yts.mx/assets/images/movies/amazing_grace_1974/small-cover.jpg",
  "medium_cover_image": "https://yts.mx/assets/images/movies/amazing_grace_1974/medium-cover.jpg",
  "large_cover_image": "https://yts.mx/assets/images/movies/amazing_grace_1974/large-cover.jpg",
  "state": "ok",
  "torrents": [
    {
      "url": "https://yts.mx/torrent/download/C50D86FE1358A19CC0EA5131311A9A3522EE9757",
      "hash": "C50D86FE1358A19CC0EA5131311A9A3522EE9757",
      "quality": "720p",
      "type": "bluray",
      "is_repack": "0",
      "video_codec": "x264",
      "bit_depth": "8",
      "audio_channels": "2.0",
      "seeds": 0,
      "peers": 0,
      "size": "899.34 MB",
      "size_bytes": 943026340,
      "date_uploaded": "2025-01-21 18:27:00",
      "date_uploaded_unix": 1737480420
    },
    {
      "url": "https://yts.mx/torrent/download/F21C8DC8537D394D511C7990CD402C6B05233486",
      "hash": "F21C8DC8537D394D511C7990CD402C6B05233486",
      "quality": "1080p",
      "type": "bluray",
      "is_repack": "0",
      "video_codec": "x264",
      "bit_depth": "8",
      "audio_channels": "2.0",
      "seeds": 0,
      "peers": 0,
      "size": "1.63 GB",
      "size_bytes": 1750199173,
      "date_uploaded": "2025-01-21 19:53:41",
      "date_uploaded_unix": 1737485621
    }
  ],
  "date_uploaded": "2025-01-21 18:27:00",
  "date_uploaded_unix": 1737480420
}
');


To search for the movie title and output only the specific fields (url, title, year, and rating), you can use the following query:


SELECT 
  JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.id')) AS id,
  JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.url')) AS url,
  JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.title')) AS title,
  JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.year')) AS year,
  JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.rating')) AS rating
FROM movies
WHERE JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.title')) = 'Amazing Grace';



SELECT 
  JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.id')) AS id,
  JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.url')) AS url,
  JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.title')) AS title,
  JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.year')) AS year,
  JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.rating')) AS rating
FROM movies
WHERE JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.title')) LIKE 'the%';







### SQL commands

```

# clear the movies table
TRUNCATE TABLE movies;




Backup the Database:
 
mysqldump -u root -p yts > yts_backup.sql



Drop the Database

DROP DATABASE yts;



Drop the Table

DROP TABLE yts_movies;


To clear (delete all data from)

TRUNCATE TABLE movies;




Verify Removal

SHOW DATABASES;



import the yts_backup.sql file into your yts database

CREATE DATABASE yts;
mysql -u root -p yts < yts_backup.sql


```





