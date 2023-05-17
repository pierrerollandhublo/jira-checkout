# JIRA-checkout helper

A small script to easily setup your dev branch based on your JIRA ticket.

## Install

### Prerequisites

Make sure you have the following softwares: `curl` and `jq`

### Copy script

Copy the script into `/usr/local/bin/jira-checkout`

```bash
sudo chmod +x /usr/local/bin/jira-checkout
```

### Get JIRA token

Create your JIRA API token by going to `JIRA -> Account -> Security -> API tokens -> Create and manage API tokens` 

### Create env vars

Create the following env vars:

```env
JIRA_HOME=https://foobar.atlassian.net
JIRA_USER=your-email
JIRA_CHECKOUT_TOKEN=your-jira-token
```

## Usage

You can specify either the issue link, or its id:

```bash
jira-checkout https://foobar.atlassian.net/browse/FOO-1337
```

```bash
jira-checkout FOO-1337
```

Your branch will be created, including the id and title, set up to track the upstream one that will be created as well.
