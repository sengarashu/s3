#!/bin/sh 
outputFile="BAapplication.bin"
amzFile="firmware/105013/2.0.1/BAapplication.bin"
region="eu-central-1"
bucket="sku-assets-dev"
# Store this securly DO NOT EXPOSE TO PULIC
s3Key=""
s3Secret=""
resource="/${bucket}/${amzFile}"
contentType="binary/octet-stream"
dateValue=`TZ=GMT date -R`
# You can leave our "TZ=GMT" if your system is already GMT (but don't have to)
stringToSign="GET\n\n${contentType}\n${dateValue}\n${resource}"
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
curl -H "Host: s3-${region}.amazonaws.com" \
     -H "Date: ${dateValue}" \
     -H "Content-Type: ${contentType}" \
     -H "Authorization: AWS ${s3Key}:${signature}" \
     https://s3-${region}.amazonaws.com/${bucket}/${amzFile} -o $outputFile