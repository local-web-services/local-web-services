# Session Context

**Session ID:** 1c9632fc-f797-49a8-901c-95079a0fd094

**Commit Message:** Make check is failing

## Prompt

make check is failing

## Summary

All checks pass for our code and the package is reinstalled. The complexity issue is fixed by extracting `_read_json_from_fd` as a separate static method. You can test now — containers should disappear from `docker ps` after each invocation completes.

## Key Actions

- - **Bash**: Run make check to see failures
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Bash**: Re-run make check after refactor
- - **Bash**: Auto-format docker.py with black
- - **Bash**: Re-run make check after formatting
- - **Bash**: Reinstall package with latest changes
