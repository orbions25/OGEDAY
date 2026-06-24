# Release Checklist

Use this template before deploying changes to `ogedays.com`.

## Release target

- Release name:
- Related merge request:
- Related QA validation:
- Production URL:
- Release owner:

## Pre-deploy checks

- [ ] Merge request is approved
- [ ] Pipeline is green
- [ ] QA Validation issue is approved
- [ ] Rollback plan is documented
- [ ] Production access request exists, if needed
- [ ] No secrets or private operational data are included

## Deploy window

- Planned date and time:
- Expected duration:
- People online during deploy:
- Communication channel:

## Post-deploy smoke test

- [ ] `https://ogedays.com/` loads
- [ ] `https://www.ogedays.com/` redirects or loads as expected
- [ ] Main CTA mailto link works
- [ ] Language switcher works
- [ ] Mobile menu works
- [ ] `robots.txt` is reachable
- [ ] `sitemap.xml` is reachable
- [ ] Security headers are present

## Rollback

- Rollback trigger:
- Rollback owner:
- Rollback command or process:
- Validation after rollback:

## Release decision

- [ ] Released
- [ ] Rolled back
- [ ] Cancelled

Decision note:

