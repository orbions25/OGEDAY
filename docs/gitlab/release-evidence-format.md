# OGEDAY Release Evidence Format

Use this format in QA Validation issues, Release Checklist issues, and post-deploy notes.

## Required evidence

Every release validation should include:

- Environment
- URL
- Date and time
- Validator
- Browser or command used
- Expected result
- Actual result
- Pass/fail decision
- Follow-up issue, if failed

## Command evidence

Use command evidence for HTTP, SEO, headers, and file checks.

```text
Command:
curl -I https://ogedays.com/

Expected:
HTTP 200 or expected redirect.

Actual:
Paste the relevant status line and headers here.

Decision:
Pass / fail.
```

## Browser evidence

Use browser evidence for visual and interaction checks.

```text
Surface:
Homepage / mobile menu / language switcher / CTA

Viewport:
Desktop or mobile size.

Expected:
Describe expected behavior.

Actual:
Describe observed behavior.

Decision:
Pass / fail.
```

## Release summary

```text
Release:
Related MR:
Related QA issue:
Related Release Checklist:
Validated by:
Decision:
Rollback needed:
Follow-up:
```

