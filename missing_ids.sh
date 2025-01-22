#!/bin/bash

DB_USER="root"
DB_PASS="123"
DB_NAME="yts"
TABLE_NAME="movies"
OUTPUT_FILE="missing_ids.txt"

# Clear the output file at the beginning
> $OUTPUT_FILE

# Fetch existing IDs from the database
existing_ids=$(mysql -u $DB_USER -p$DB_PASS -D $DB_NAME -se "SELECT JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.id')) FROM $TABLE_NAME WHERE JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.id')) BETWEEN 1 AND 65026;")

# Loop through the range and find missing IDs
for id in $(seq 1 65026); do
    if ! echo "$existing_ids" | grep -qw "$id"; then
        echo "ID $id is not in the list" >> $OUTPUT_FILE
    fi
done

