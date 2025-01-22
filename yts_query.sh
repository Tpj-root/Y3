#!/bin/bash

# MySQL credentials
MYSQL_HOST="localhost"
MYSQL_USER="root"
MYSQL_PASS="123"
MYSQL_DB="yts"

# Check if YAD is installed
if ! command -v yad &> /dev/null; then
    echo "YAD is not installed. Install it using: sudo apt install yad"
    exit 1
fi

# Loop until user clicks "Exit"
while true; do
    # Prompt user for a name and year
    INPUT=$(yad --form --title="Search by Name and Year" \
        --text="Enter the search criteria (leave fields empty if not applicable):" \
        --field="Name" --field="Year" \
        --width=400 --height=200)

    # Extract user inputs
    NAME=$(echo "$INPUT" | awk -F '|' '{print $1}')
    YEAR=$(echo "$INPUT" | awk -F '|' '{print $2}')

    # Check if both inputs are empty
    if [[ -z "$NAME" && -z "$YEAR" ]]; then
        yad --info --title="No Input" --text="No name or year provided. Exiting."
        exit 0
    fi

    # Construct the SQL query based on input
    if [[ -n "$NAME" && -n "$YEAR" ]]; then
        SQL_QUERY="
        SELECT 
          JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.id')) AS id,
          JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.url')) AS url,
          JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.title')) AS title,
          JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.year')) AS year,
          JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.rating')) AS rating
        FROM movies
        WHERE JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.title')) LIKE '$NAME%' 
          AND JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.year')) = '$YEAR'
        ;"
    elif [[ -n "$NAME" ]]; then
        SQL_QUERY="
        SELECT 
          JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.id')) AS id,
          JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.url')) AS url,
          JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.title')) AS title,
          JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.year')) AS year,
          JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.rating')) AS rating
        FROM movies
        WHERE JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.title')) LIKE '$NAME%'
        ;"
    elif [[ -n "$YEAR" ]]; then
        SQL_QUERY="
        SELECT 
          JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.id')) AS id,
          JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.url')) AS url,
          JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.title')) AS title,
          JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.year')) AS year,
          JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.rating')) AS rating
        FROM movies
        WHERE JSON_UNQUOTE(JSON_EXTRACT(movie_json, '$.year')) = '$YEAR'
        ;"
    fi

    # Execute the query and capture the output
    QUERY_OUTPUT=$(mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASS" -D "$MYSQL_DB" -e "$SQL_QUERY" 2>&1)

    # Check for errors
    if [[ $? -ne 0 ]]; then
        yad --error --title="Query Error" --text="An error occurred:\n$QUERY_OUTPUT"
        continue
    fi

    # Check if the output is empty (no rows found)
    if [[ $(echo "$QUERY_OUTPUT" | wc -l) -le 1 ]]; then
        yad --info --title="No Results" --text="No results found for the given criteria."
        continue
    fi

    # Format the query output for readability
    FORMATTED_OUTPUT=$(echo "$QUERY_OUTPUT" | sed '1d')  # Remove MySQL headers for cleaner display

    # Display the output in a text dialog
    yad --text-info --title="Query Result" \
        --width=800 --height=600 \
        --editable \
        --wrap \
        --text="$FORMATTED_OUTPUT"

    echo "$QUERY_OUTPUT" > Query_result.txt

    # Ask the user if they want to continue or exit
    RESULT=$(yad --question --title="Continue?" --text="Do you want to make another query?" --button="Yes:0" --button="Exit:1")
    
    # Exit if the user clicked "Exit"
    if [[ $? -eq 1 ]]; then
        exit 0
    fi
done
