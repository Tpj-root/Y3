#!/bin/bash

# Database credentials
DB_USER="root"
DB_PASS="123"
DB_NAME="yts"
TABLE_NAME="movies1"

# Path to the directory containing your JSON files
INPUT_DIR="/home/sab/Desktop/MY_GIT/Y3/id2json/1"

# Loop through each JSON file in the directory
for file in "$INPUT_DIR"/*.json; do
  # Extract the movie_id from the file
  movie_id=$(jq -r '.data.movie.id' "$file")
  
  # Extract the full movie details as JSON
  movie_json=$(jq -c '.data.movie' "$file")

  # Escape single quotes in movie_json for safe insertion
  movie_json=$(echo "$movie_json" | sed "s/'/\\\'/g")

  # Insert data into the MySQL table
  query="INSERT INTO $TABLE_NAME (movie_id, movie_json) VALUES ($movie_id, '$movie_json');"
  mysql -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "$query"

  # Optional: print progress
  if [ $? -eq 0 ]; then
    echo "Inserted movie ID: $movie_id from file: $file"
  else
    echo "Failed to insert movie ID: $movie_id from file: $file"
  fi
done

echo "All data has been inserted into the database."

