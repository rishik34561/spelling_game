#!/bin/bash
set -x
while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "this line is $line"
    curl -o /Users/rishi/software/apache-tomcat-7.0.42/webapps/test/audio_files/$line.mp3 -k https://ssl.gstatic.com/dictionary/static/sounds/oxford/$line--_gb_1.mp3
done < "$1"