#!/bin/bash
# id 2 download the json files



# Initialize the empty slots list
> empty_slots_ids.txt

# Loop through each ID in the ID.txt file
while read id; do
    success=0
    while [ $success -eq 0 ]; do
        # Construct the URL with the current ID
        url="https://yts.mx/api/v2/movie_details.json?movie_id=$id"
        
        # Fetch the data and store it in a variable
        response=$(curl -s "$url")
        
        # Save the response to a file named movie_details_<id>.json
        echo "$response" > "movie_details_$id.json"
        
        # Check if the response is valid JSON
        if echo "$response" | jq . > /dev/null 2>&1; then
            # If valid JSON, extract the movie ID
            movie_id=$(echo "$response" | jq '.data.movie.id')
            
            # Check if the movie ID is 0 (empty slot)
            if [ "$movie_id" -eq 0 ]; then
                # If the movie ID is 0, the slot is empty, so store it
                echo "$id" >> empty_slots_ids.txt
                echo "ID $id is empty, added to empty_slots_ids.txt"
                
                # Remove the file if the ID is empty
                rm -rf "movie_details_$id.json"
                
                success=1
            else
                # If the movie ID is non-zero, consider it successful
                echo "Movie details for ID $id fetched successfully"
                success=1
            fi
        else
            # Retry on invalid JSON response
            echo "Error fetching details for ID $id: Invalid JSON, retrying..."
        fi
    done
done < ID.txt

