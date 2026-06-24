# OGEDAY GitLab Backup and Restore Checklist

Backups are not complete until restore has been tested. Use this checklist before GitLab becomes the only source of truth for OGEDAY.

## Backup scope

- [ ] Git repositories
- [ ] Issues and merge requests
- [ ] Wiki, snippets, and uploads if used
- [ ] CI/CD variables
- [ ] Runner configuration notes
- [ ] Container registry if enabled
- [ ] GitLab configuration files
- [ ] TLS certificates and DNS notes

## Backup policy

- Backup owner:
- Storage location:
- Retention period:
- Encryption method:
- Restore test frequency:
- Offsite copy location:

## Restore test

- [ ] Restore target prepared
- [ ] Latest backup restored
- [ ] Repository history verified
- [ ] Issues and merge requests verified
- [ ] CI variables verified or re-entered securely
- [ ] Runner access reconnected
- [ ] Test pipeline executed
- [ ] Admin login verified

## Recovery decision

- Recovery time objective:
- Recovery point objective:
- Emergency contact:
- Decision maker:
- Communication channel:

## Notes

Record every restore test result here or link the related issue.

