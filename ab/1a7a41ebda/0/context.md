# Session Context

**Session ID:** 1c9632fc-f797-49a8-901c-95079a0fd094

**Commit Message:** ./test-orders.sh
=== Creating order ===
{
    "status": 500,
    "header

## Prompt

./test-orders.sh
=== Creating order ===
{
    "status": 500,
    "headers": {
        "date": "Wed, 11 Feb 2026 02:23:25 GMT",
        "server": "uvicorn",
        "content-length": "988",
        "content-type": "application/json"
    },
    "body": {
        "error": "Failed to parse container output: 'TypeError: Invalid URL\\n    at new URL (node:internal/url:806:29)\\n    at /var/task/node_modules/@aws-sdk/middleware-sdk-sqs/dist-cjs/index.js:21:44\\n    at /var/task/node_modules/@smithy/middleware-endpoint/dist-cjs/index.js:186:16\\n    at process.processTicksAndRejections (node:internal/process/task_queues:95:5)\\n    at async /var/task/node_modules/@aws-sdk/middleware-sdk-sqs/dist-cjs/index.js:88:18\\n    at async /var/task/node_modules/@aws-sdk/middleware-logger/dist-cjs/index.js:5:26\\n    at async exports.handler (/var/task/index.js:27:3)\\n    at async main (/var/bootstrap/invoker.js:39:20) {\\n  code: \\'ERR_INVALID_URL\\',\\n  input: \\'null\\'\\n}\\n{\"result\":{\"statusCode\":201,\"headers\":{\"Content-Type\":\"application/json\"},\"body\":\"{\\\\\"orderId\\\\\":\\\\\"f4210e09-4e64-4a04-b03d-e19c29a171e7\\\\\",\\\\\"status\\\\\":\\\\\"CREATED\\\\\",\\\\\"createdAt\\\\\":\\\\\"2026-02-11T02:23:26.396Z\\\\\"}\"}}'"
    }
}
Traceback (most recent call last):
  File "<string>", line 1, in <module>
    import sys,json; print(json.load(sys.stdin)['body']['orderId'])
                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^
KeyError: 'orderId'

## Summary

Fixed. The issue was that `_strip_docker_stream_framing` was extracting **all** frames (stdout + stderr) into a single buffer. The AWS SDK's `TypeError: Invalid URL` error was written to stderr and got prepended to the stdout JSON result, breaking the parse.

The new `_demux_docker_stream` method separates the Docker multiplexed stream by frame type — stdout (type 1) is returned for JSON parsing, stderr (type 2) is logged at debug level separately.

## Key Actions

- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Edit**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/docker.py
- - **Bash**: Lint and run tests
