#!/bin/sh
S3_BUCKET=$1
/usr/bin/aws s3 sync /klondike/data s3://${S3_BUCKET} --sse AES256 --delete