# Project Context

## Purpose
LDK (Local Development Kit) is an open-source tool that reads AWS CDK cloud assembly output and recreates the described application locally. It provides transparent SDK redirection, hot reload, debugging, and CDK-aware validation — giving developers a fast, zero-cost, zero-credential local development environment for cloud-native applications.

## Tech Stack
- **Language**: Python 3.11+
- **CLI**: Typer
- **HTTP server**: FastAPI (uvicorn)
- **File watching**: watchdog
- **SQLite access**: aiosqlite
- **Cron parsing**: croniter
- **Testing**: pytest, pytest-asyncio
- **Package management**: uv (monorepo with workspaces)

## Project Conventions

### Code Style
- Follow PEP 8 with 100-character line length
- Use type hints on all public function signatures
- Use `async`/`await` throughout (FastAPI is async)
- Use dataclasses or Pydantic models for structured data

### Architecture Patterns
- Provider abstraction: all AWS service providers implement abstract interfaces from `ldk-interfaces`
- Capability-based interfaces: interfaces defined in terms of capabilities (queue, store), not AWS API shapes
- SDK redirection via `AWS_ENDPOINT_URL_*` environment variables
- Application graph: directed graph of resources and their relationships derived from CDK cloud assembly

### Testing Strategy
- Unit tests for all modules using pytest
- Integration tests using pre-synthesized CDK cloud assembly fixtures
- End-to-end tests that start the full local environment and exercise HTTP/SDK paths
- Provider conformance test suites for verifying interface compliance

### Git Workflow
- Feature branches off `main`
- Conventional commits
- PR-based review

## Domain Context
- CDK cloud assembly is the output of `cdk synth`, stored in `cdk.out/`
- `tree.json` contains the CDK construct hierarchy with high-level type information
- CloudFormation templates contain detailed resource properties
- AWS SDKs respect `AWS_ENDPOINT_URL` and service-specific variants for custom endpoints

## Important Constraints
- Zero AWS credentials required for local development
- Application code must run unchanged (no wrapper libraries or conditional imports)
- Provider interfaces must be implementation-agnostic to support future production providers
- Eventual consistency simulation where AWS exhibits it (default 200ms delay, configurable)

## External Dependencies
- AWS CDK CLI (for `cdk synth`)
- Node.js 18+ (for running Node.js Lambda handlers)
- Python 3.11+ (for running Python Lambda handlers and LDK itself)
