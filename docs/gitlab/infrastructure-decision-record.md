# OGEDAY GitLab Infrastructure Decision Record

Use this file to record decisions before self-hosted GitLab becomes operational.

## Decision table

| Topic | Decision | Owner | Date | Notes |
| --- | --- | --- | --- | --- |
| GitLab FQDN | `gitlab.ogedays.com` |  |  | Confirm DNS before install. |
| DNS provider |  |  |  |  |
| GitLab server provider |  |  |  |  |
| GitLab server region |  |  |  |  |
| GitLab server size |  |  |  | Record CPU, RAM, and disk. |
| Backup storage |  |  |  | Must be outside the GitLab server. |
| Restore-test target |  |  |  | Must match GitLab version and type. |
| Runner machine |  |  |  | Prefer separate machine. |
| Software Admin owner |  |  |  |  |
| Supervisor owner |  |  |  |  |
| Emergency contact |  |  |  |  |
| GitHub fallback owner |  |  |  |  |

## Decision rules

- Do not install GitLab before FQDN and backup storage decisions are recorded.
- Do not make GitLab primary before restore has been tested.
- Do not remove GitHub fallback before cutover is approved.
- Do not store server credentials, tokens, private keys, or DNS account details in this file.

