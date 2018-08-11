#!/bin/bash

GIT_COMMIT_FULL_MESSAGE=`git log -1`
GIT_COMMIT_MESSAGE=`git log -1 --pretty=%B`
GIT_COMMIT_SHA=`git rev-parse HEAD`
GIT_COMMIT_BRANCH=`git rev-parse --abbrev-ref HEAD`
GIT_COMMIT_AUTHOR_NAME=`git log -1 --pretty=format:'%an'`
GIT_COMMIT_AUTHOR_EMAIL=`git log -1 --pretty=format:'%ae'`
GIT_COMMIT_TIMESTAMP=`git show -s --format=%ct`
GIT_COMMIT_PERMALINK_URL=$(echo $GIT_PERMALINK_PATTERN | sed -e "s/\$GIT_COMMIT_SHA/$GIT_COMMIT_SHA/g")

read -r -d '' WEBHOOK_DATA <<curldataEOT
{
  "attachments":[
    {
      "fallback": "Building ${GIT_COMMIT_SHA} (${GIT_COMMIT_BRANCH})\n${GIT_COMMIT_MESSAGE}",
      "color": "#24a2b7",
      "pretext": "Building `${GIT_COMMIT_SHA}` (${GIT_COMMIT_BRANCH})",
      "author_name": "${GIT_COMMIT_AUTHOR_NAME}",
      "title": "${GIT_COMMIT_MESSAGE}",
      "title_link": "${GIT_COMMIT_PERMALINK_URL}",
      "ts": ${GIT_COMMIT_TIMESTAMP}
    }
  ]
}
curldataEOT

curl $SLACK_WEBHOOK_URL \
  --header "Content-Type: application/json" \
  --request POST \
  --data "${WEBHOOK_DATA}"
