# Session Context

**Session ID:** f7436bbb-ae80-4d39-be8c-74e1d982092c

**Commit Message:** If docker is unavailable I want to surface a message to the user explain

## Prompt

If docker is unavailable I want to surface a message to the user explaining what the problem is

## Summary

All 26 tests pass. Here's what changed:

**`src/lws/providers/neptune/data_plane.py`** — `start()` catches exceptions silently (debug log only) so `ldk dev` doesn't crash when Docker is unavailable. The `available` property tracks whether the container actually started.

**`src/lws/cli/ldk.py`** — New `_print_data_plane_warnings()` function prints a clear Rich-formatted message after startup when the JanusGraph container didn't start:

```
Warning: Neptune data-plane (JanusGraph) is not available. Docker may not be running or the image is not pulled.
  Run lws ldk setup neptune to pull the JanusGraph image.
  Neptune control-plane will still work but clusters will have synthetic endpoints.
```

The control-plane endpoint conditionally uses `neptune_data.endpoint if neptune_data.available else None`, so without Docker it falls back to synthetic endpoints instead of crashing.

## Key Actions

- - **Grep**: from lws.cli.display import
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/display.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/ldk.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/neptune/data_plane.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/neptune/data_plane.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/ldk.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/ldk.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/ldk.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/ldk.py
- - **Bash**: Run ruff and black on changed files
