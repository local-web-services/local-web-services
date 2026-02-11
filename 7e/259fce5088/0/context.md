# Session Context

**Session ID:** 1c9632fc-f797-49a8-901c-95079a0fd094

**Commit Message:** I am now seeing the logs in the cli only and not the web ui. eg: 

[21:5

## Prompt

I am now seeing the logs in the cli only and not the web ui. eg: 

[21:51:11] SNS POST / -> Publish (2ms) -> 200
INFO ldk.docker-compute: OK ProcessOrderFunction50B96DD0 (1417ms, request=f5176e26-e4f4-437f-91f9-af87b5283a6e)
[21:51:11] APIGATEWAY GET /_ldk/resources -> apigateway (0ms) -> 200
[21:51:11] STEPFUNCTIONS POST / -> DescribeExecution (0ms) -> 200

however I want the logs to show the service consistently like others - eg show lambda. I want it to appear in the web gui and I want to see the lambda function arguements for context and event in the web ui

## Summary

All passing. Here's what changed:

1. **New `log_lambda_invocation` method on `LdkLogger`** (`logger.py`) — Formats Lambda invocations consistently with other services (`[HH:MM:SS] LAMBDA ProcessOrderFunction (234ms) -> OK`) and emits structured entries to the WebSocket handler with `service: "lambda"`. Includes `event` as `request_body` and `result` as `response_body` so the web GUI can display the function arguments and return value.

2. **`DockerCompute` switched from `logging.getLogger` to `get_logger`** (`docker.py`) — Now uses `LdkLogger` which outputs to both the Rich console (CLI) and the WebSocket handler (web GUI).

3. **Invocation logging uses `log_lambda_invocation`** — Every invocation (success, error, timeout) goes through the structured logger, showing up in both CLI and web GUI with the event payload and result.

## Key Actions

- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/logging/logger.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/logging/middleware.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/logging/logger.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Bash**: Lint and run tests
