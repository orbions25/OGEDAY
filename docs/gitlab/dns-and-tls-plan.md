# OGEDAY GitLab DNS and TLS Plan

This plan defines the DNS and TLS expectations for the self-hosted GitLab pilot.

## DNS target

Recommended record:

```text
gitlab.ogedays.com  A  <gitlab-server-public-ip>
```

If IPv6 is used:

```text
gitlab.ogedays.com  AAAA  <gitlab-server-public-ipv6>
```

## DNS checklist

- [ ] Confirm DNS provider account owner.
- [ ] Confirm target GitLab server public IP.
- [ ] Add `A` record for `gitlab.ogedays.com`.
- [ ] Keep TTL short during pilot, for example 300 seconds.
- [ ] Verify from local machine.
- [ ] Verify from the target server.
- [ ] Document the final record in the decision record.

## TLS approach

Use HTTPS for the GitLab instance. The simplest path is to set:

```text
external_url "https://gitlab.ogedays.com"
```

Then let the GitLab Linux package manage HTTPS according to the selected configuration.

## Firewall checklist

The GitLab server should intentionally expose only what is needed:

- SSH: `22`
- HTTP: `80`
- HTTPS: `443`

SSH should be limited or rate-limited where possible.

## Verification checklist

- [ ] `gitlab.ogedays.com` resolves.
- [ ] `http://gitlab.ogedays.com` reaches the GitLab server or redirects as expected.
- [ ] `https://gitlab.ogedays.com` loads after install.
- [ ] Git clone URLs show the GitLab FQDN.
- [ ] No production secrets are stored in DNS notes or repository files.

