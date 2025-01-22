#!/bin/bash

# Database credentials
DB_USER="root"
DB_PASS="123"
DB_NAME="yts"
TABLE_NAME="movies"

# Path to the directory containing your JSON files
INPUT_DIR="/home/sab/Desktop/MY_GIT/YTS_DOWNLOAD_2025/yts_movie_data/"

# Loop through each JSON file (page_1.json to page_1299.json)
for file in $INPUT_DIR/page_*.json; do
  # Get the number of movies in the file (assuming there are 50 movies per page)
  movie_count=$(jq '.data.movies | length' "$file")

  # Loop through each movie and insert it into the database
  for ((i=0; i<movie_count; i++)); do
    # Extract the movie_id and the movie_json from the file
    movie_id=$(jq -r ".data.movies[$i].id" "$file")
    movie_json=$(jq -c ".data.movies[$i]" "$file")

    # Escape single quotes and special characters
    movie_json=$(echo "$movie_json" | sed "s/'/\\\'/g" | sed 's/"/\\"/g')

    # Wrap movie_json in single quotes to properly insert into SQL
    movie_json="'$movie_json'"

    # Insert data into the MySQL table
    query="INSERT INTO $TABLE_NAME (movie_id, movie_json) VALUES ($movie_id, $movie_json);"
    mysql -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "$query"
    
    # Optional: print progress
    echo "Inserted movie ID: $movie_id"
  done
  sleep 2
done

echo "All data has been inserted into the database."

