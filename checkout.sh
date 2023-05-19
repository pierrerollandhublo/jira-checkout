#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Please specify a JIRA ticket"
  exit -1
fi

JIRA_ID=$(echo $1 | sed -E "s|^($JIRA_HOME/browse/)?([^/]+).*|\2|")
JIRA_ISSUE_CONTENT=$(curl -s -X GET --user "$JIRA_USER:$JIRA_CHECKOUT_TOKEN" -H "Content-Type: application/json" "$JIRA_HOME/rest/api/3/issue/$JIRA_ID")
JIRA_ISSUE_TYPE=$(echo $JIRA_ISSUE_CONTENT | jq -r '.fields.issuetype.name')

if [ "$JIRA_ISSUE_TYPE" = "Story" ] || [ "$JIRA_ISSUE_TYPE" = "Task" ] || [ "$JIRA_ISSUE_TYPE" = "Tâche" ] || [ "$JIRA_ISSUE_TYPE" = "Sub-task" ] || [ "$JIRA_ISSUE_TYPE" = "Sous-tâche" ]; then
    JIRA_BRANCH_TYPE="feat"
elif [ "$JIRA_ISSUE_TYPE" = "Bug" ]; then
    JIRA_BRANCH_TYPE="fix"
else
    JIRA_BRANCH_TYPE="chore"
fi

JIRA_BRANCH_NAME="$JIRA_BRANCH_TYPE/$JIRA_ID-$(echo $JIRA_ISSUE_CONTENT | jq -r '.fields.summary' | sed -E 's/[^A-Za-z0-9]+/-/g' | tr '[:upper:]' '[:lower:]' | sed -E 's/^-*(.+)-*$/\1/')"

git checkout -b $JIRA_BRANCH_NAME
git push --set-upstream origin $JIRA_BRANCH_NAME
