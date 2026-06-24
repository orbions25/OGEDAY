# OGEDAY Automation Readiness

Automation should be added only after the manual workflow has produced enough evidence.

## Do not automate yet

Do not add production deployment automation until:

- GitLab install is stable.
- Runner is stable.
- Backup and restore test has passed.
- At least one dry-run release checklist is complete.
- At least one real QA validation has passed.
- Access request flow has been rehearsed.

## Good first automation candidates

Automate these only after the first pilot week:

- Label creation from `ops/gitlab/apply-labels.sh`
- Project readiness checks from `ops/gitlab/project-readiness-check.sh`
- Pilot issue creation from `ops/gitlab/create-pilot-issues.sh`
- Monthly governance report draft from issue and MR data
- Access expiry reminders

## Bad first automation candidates

Avoid these until the team has repeated the workflow safely:

- Automatic production deploy
- Automatic permission grants
- Automatic secret rotation
- Automatic branch unprotection
- Automatic rollback without human approval

## Readiness score

Use this score before adding each automation:

| Question | Yes/No |
| --- | --- |
| Is the manual workflow documented? |  |
| Has the manual workflow succeeded at least twice? |  |
| Is there a rollback or undo path? |  |
| Is the owner clear? |  |
| Does the automation avoid storing secrets in the repo? |  |
| Can it run in dry-run mode first? |  |

Only automate when every answer is yes.

