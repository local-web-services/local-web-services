# LDK - Local Development Kit

Run your AWS CDK applications locally. LDK reads your CDK project's synthesized CloudFormation templates and spins up local emulations of API Gateway, Lambda, DynamoDB, SQS, SNS, S3, and Step Functions so you can develop and test without deploying to AWS.

## Installation

LDK requires Python 3.11+ and [uv](https://docs.astral.sh/uv/).

```bash
uv tool install ldk
```

Or install from source:

```bash
git clone https://github.com/local-development-kit/ldk.git
cd ldk
uv sync
```

## Quick Start

1. Make sure your CDK project has been synthesized:

```bash
cd your-cdk-project
npx cdk synth
```

2. Start LDK:

```bash
ldk dev --project-dir /path/to/your-cdk-project --port 3000
```

3. Send requests to your local endpoints:

```bash
curl -X POST http://localhost:3000/orders \
  -H 'Content-Type: application/json' \
  -d '{"customerName": "Alice", "items": ["widget"]}'

curl http://localhost:3000/orders/some-id
```

LDK will discover your API routes, Lambda functions, DynamoDB tables, SQS queues, SNS topics, S3 buckets, and Step Functions state machines automatically from the CDK output.

## Supported Services

| Service | Status |
|---------|--------|
| API Gateway (HTTP API) | Supported |
| Lambda (Node.js, Python) | Supported |
| DynamoDB | Supported |
| SQS | Supported |
| SNS | Supported |
| S3 | Supported |
| Step Functions | Supported |

## Development

All development tasks are available through `make`:

```bash
make install       # Install dependencies
make test          # Run test suite
make lint          # Run linter
make format        # Auto-format code
make check         # Run all checks (lint, format, complexity, tests)
```

Run `make` with no arguments to see all available targets.

## Documentation

Visit [https://github.com/local-development-kit/ldk-site](https://github.com/local-development-kit/ldk-site) for full documentation.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
