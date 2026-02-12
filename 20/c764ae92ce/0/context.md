# Session Context

**Session ID:** ea66a7bf-fd2d-4f55-9989-d4d4f88c260d

**Commit Message:** Ldk dev pulls images. I want them to only pull when I run the setup comm

## Prompt

ldk dev pulls images. I want them to only pull when I run the setup commands

## Summary

All 2004 tests pass. 

Now, regarding your second message — that log output shows the old auto-pull behavior. With the change I just made, `DockerServiceManager.start()` will now raise a `RuntimeError` if the image isn't found locally, instead of pulling it. The `DataPlaneProvider.start()` catches that exception and marks the service as unavailable, which triggers the warning message telling the user to run `lws ldk setup <service>`.

So after this change:
- `lws ldk dev` — will **not** pull images. If an image is missing, the data plane is marked unavailable and a warning is printed.
- `lws ldk setup <service>` — is the **only** way to pull images (this was already implemented and unchanged).

## Key Actions

- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/_shared/docker_service.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/_shared/docker_service.py
- - **Bash**: Run tests to verify change
