# Docker Klondike
## Mono based

Docker container to run a Self Hosted version of [Klondike](https://github.com/themotleyfool/Klondike). Klondike is a Nuget repository that can be used to host your own private Nuget repository.

By default, it will run statelessly, so rebooting will cause you to lose all of your packages. This image can be setup to allow direct backup to S3 bucket, or can be configured to mount the data directory as a volume for your own backup solution.

# Usage
## Persist Package directory
```
docker run -it -p 8080:8080 \
               -v /some/host/directory/:/klondike/data/ \
               --name klondike \
               asyncrony/docker-klondike
```
This will start the container and mount the packages folder to a host location. You can backup in any way you like from there.

## S3 Backup
```
docker run -it -p 8080:8080 \
               -v ~/.aws/credentials:/root/.aws/credentials \
               -e S3_BUCKET=**SOME_S3_BUCKET** \
               asyncrony/docker-klondike
```
In order to use the S3 Backup feature you will need AWS credentials on the host running the container, and you will need to mount them in to the container like the above example. If running on an EC2 instance, you will need to grant the instance permission to the correct bucket. If running on EC2, omit the mounted volume in the above example. The bucket name *should not* contain the s3:// prefix.
