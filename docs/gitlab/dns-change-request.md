# OGEDAY GitLab DNS Change Request

Use this request when asking the DNS owner to create or update the GitLab hostname.

## Requested change

Create the following DNS record:

```text
Type: A
Name: gitlab
FQDN: gitlab.ogedays.com
Value: <gitlab-server-public-ip>
TTL: 300 during pilot
```

If the GitLab server has IPv6:

```text
Type: AAAA
Name: gitlab
FQDN: gitlab.ogedays.com
Value: <gitlab-server-public-ipv6>
TTL: 300 during pilot
```

## Reason

OGEDAY self-hosted GitLab needs a stable HTTPS hostname before installation can be treated as ready.

## Acceptance criteria

- [ ] `gitlab.ogedays.com` resolves from a local machine.
- [ ] `gitlab.ogedays.com` resolves from the target GitLab server.
- [ ] DNS value matches the selected GitLab server public IP.
- [ ] Decision is recorded in `docs/gitlab/infrastructure-decision-record.md`.
- [ ] DNS readiness script passes or reports only expected warnings.

## Validation commands

Windows:

```powershell
powershell -ExecutionPolicy Bypass -File ops/gitlab/dns-readiness.ps1 -FailOnMissingGitLab
```

Linux:

```bash
FAIL_ON_MISSING_GITLAB=1 sh ops/gitlab/dns-readiness.sh
```

