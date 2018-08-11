# Git/Slack CloudBuild Notification

This is a quick-n-dirty script to notify Slack in a CloudBuild step.

## Usage

When the notify.sh script runs inside the container, it expects the following ENVs:

```
GIT_PERMALINK_PATTERN="https://github.com/[your-repo]/[your-project]/$GIT_COMMIT_SHA/"
SLACK_WEBHOOK_URL=[your url]
```

## Example

Add the following to your `cloudbuild.yaml` (replacing `bfolkens/gcb_slack_notifier` and the webhook with your own):

```
- name: 'bfolkens/gcb_slack_notifications'
  env:
    - 'SLACK_WEBHOOK_URL=https://hooks.slack.com/services/ABACADABA/DEADBEEF/and0n3m0r3v4r'
    - 'GIT_PERMALINK_PATTERN="https://github.com/bfolkens/gcb_slack_notifier/$GIT_COMMIT_SHA/"'
```
