# Session Context

**Session ID:** 1c9632fc-f797-49a8-901c-95079a0fd094

**Commit Message:** Ahh the docker containers not exiting are the ones in docker ps

## Prompt

ahh the docker containers not exiting are the ones in docker ps

## Summary

Now after each Lambda invocation, the container is stopped and removed — it won't linger in `docker ps`. A fresh container is created on the next invocation via `_ensure_container()`. The tradeoff is a small cold-start per invocation (container creation), but you get clean `docker ps` output.

## Key Actions

- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Bash**: Reinstall package to pick up container cleanup change
