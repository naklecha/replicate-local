echo "\e[32m"
cat << "EOF"
 
 ∧,,,∧
 (• ⩊ •)            https://aaaaaaaaaa.org
|￣U U￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣

EOF
echo "\e[0m"

# Assign the first argument passed to the script to the variable IMAGE_NAME
IMAGE_NAME=$1

if [ -z "$IMAGE_NAME" ]; then
    echo "\033[31mError: No image name provided\033[0m"
    exit 1
fi

echo "\033[32mAssigned IMAGE_NAME as $IMAGE_NAME\033[0m"
# Replace all forward slashes in IMAGE_NAME with underscores and assign to CONTAINER_NAME
CONTAINER_NAME=$(echo "$IMAGE_NAME" | tr '/' '_')
echo "\033[32mConverted IMAGE_NAME to CONTAINER_NAME: $CONTAINER_NAME\033[0m"


# Run a new Docker container interactively with the name CONTAINER_NAME, using the image IMAGE_NAME, and start a bash shell
echo "\033[32mRunning Docker container named $CONTAINER_NAME with image $IMAGE_NAME\033[0m"
docker pull $IMAGE_NAME
docker run -itd --name $CONTAINER_NAME $IMAGE_NAME /bin/bash
# Copy the contents from the container's /src directory to a local directory named after the container
echo "\033[32mCopying contents from $CONTAINER_NAME:/src to ./$CONTAINER_NAME\033[0m"
docker cp $CONTAINER_NAME:/src ./$CONTAINER_NAME


# Send a SIGKILL signal to the container, effectively terminating it
echo "\033[32mKilling temporary containers and jobs\033[0m"

docker kill $CONTAINER_NAME
# Remove the container from the Docker host, deleting its filesystem
docker rm $CONTAINER_NAME

