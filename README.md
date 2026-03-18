# local-web-services

Run AWS services locally for fast, isolated tests — no Docker, no cloud account, no mocks.

Local Web Services (LWS) starts real in-process AWS service emulators that speak the native AWS
wire protocol. Your production code uses its normal AWS SDK; LWS intercepts the requests via
standard `AWS_ENDPOINT_URL_*` environment variables. No code changes required.

## Supported services

| Service | Port offset |
|---|---|
| DynamoDB | +1 |
| SQS | +2 |
| S3 | +3 |
| SNS | +4 |
| EventBridge | +5 |
| Step Functions | +6 |
| Cognito IDP | +7 |
| Lambda | +8 |
| API Gateway | +9 |
| RDS | +10 |
| DocumentDB | +11 |
| SSM Parameter Store | +12 |
| Secrets Manager | +13 |
| ElastiCache | +14 |
| Neptune | +15 |
| MemoryDB | +16 |
| Glacier | +17 |
| Elasticsearch | +18 |
| OpenSearch | +19 |
| S3 Tables | +20 |

## Language SDKs

| Language | Package | Docs |
|---|---|---|
| Python | `local-web-services-python-sdk` | [lang/python/sdk/README.md](lang/python/sdk/README.md) |
| TypeScript | `local-web-services-typescript-sdk` | [lang/typescript/sdk/README.md](lang/typescript/sdk/README.md) |
| JavaScript | `local-web-services-javascript-sdk` | [lang/javascript/sdk/README.md](lang/javascript/sdk/README.md) |
| Java | `io.localwebservices:lws-java-sdk` | [lang/java/sdk/README.md](lang/java/sdk/README.md) |
| Go | `github.com/local-web-services/local-web-services-go-sdk` | [lang/go/sdk/README.md](lang/go/sdk/README.md) |

## Repository structure

```
lang/
  python/{core,sdk,example}       # Python core (reference implementation) + SDK + example app
  typescript/{core,sdk,example}   # TypeScript core + SDK + example app
  javascript/{sdk,example}        # JavaScript SDK (wraps TypeScript core) + example app
  java/{core,sdk,example}         # Java core + SDK + example app
  go/{core,sdk,example}           # Go core + SDK + example app
  specification/core/
    informal/                     # Gherkin feature files (cross-language BDD spec)
    formal/                       # FizzBee formal model-checked specs
tools/                            # Repo maintenance scripts
```

## Documentation

**[local-web-services.github.io](https://local-web-services.github.io)**

## Building

```bash
bazel build //...
bazel test //...
```

## Releasing

Each SDK releases independently via a git tag:

| Tag | Publishes to |
|---|---|
| `python-sdk/v*` | PyPI |
| `typescript-sdk/v*` | npm |
| `javascript-sdk/v*` | npm |
| `java-sdk/v*` | GitHub Packages |
| `go-sdk/v*` | GitHub Release |
