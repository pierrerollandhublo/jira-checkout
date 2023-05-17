#!/bin/bash

JIRA_ID=$(echo $1 | sed -E "s|^($JIRA_HOME/browse/)?([^/]+).*|\2|")
JIRA_BRANCH_NAME="$JIRA_ID-$(curl -s -X GET --user "$JIRA_USER:$JIRA_CHECKOUT_TOKEN" -H "Content-Type: application/json" "$JIRA_HOME/rest/api/3/issue/$JIRA_ID" | jq -r '.fields.summary' | sed -E 's/[^A-Za-z0-9]+/-/g' | tr '[:upper:]' '[:lower:]' | sed -E 's/^-*(.+)-*$/\1/')"
git checkout -b $JIRA_BRANCH_NAME
git push --set-upstream origin $JIRA_BRANCH_NAME

