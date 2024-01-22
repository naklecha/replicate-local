#!/bin/bash

# Take a query as input
echo "\e[32m"
cat << "EOF"
 
 ∧,,,∧
 (• ⩊ •)            https://aaaaaaaaaa.org
|￣U U￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣

EOF
echo "\e[0m"

# Take a query as input
query=$1

if [ -z "$query" ]; then
    echo "\033[31mError: No search query provided\033[0m"
    exit 1
fi

# Format the curl output
encoded_query=$(echo "$query" | sed 's/ /%20/g')
response=$(curl -s "https://replicate.com/api/models/search?query=$encoded_query")

echo $response

# Use Python to parse and format the JSON output since jq is not available
echo $response | python3 -c "import sys, json; [print(f'''{item['username']}/{item['name']} [runs {item['run_count']}], {item['description']}''') for item in json.load(sys.stdin)['models']]" | while IFS= read -r line; do
    model_info=$(echo $line | cut -d',' -f1)
    description=$(echo $line | cut -d',' -f2)

    echo "\033[32mmodel:\033[0m $model_info"
    echo "\033[33m>$description\033[0m"
    
    echo
done
