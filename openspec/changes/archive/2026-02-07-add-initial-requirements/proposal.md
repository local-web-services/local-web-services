# Change: Add initial requirements for LDK

## Why
LDK is a greenfield project that needs a comprehensive set of requirements before implementation begins. These requirements are derived from three source documents: the LDK Concept Document, the Developer Experience Guide, and the Project Plan. Capturing them as formal specs enables structured review, traceability, and spec-driven development.

## What Changes
- Adds 19 capability specs covering the full LDK system:
  - **Core**: CLI, cloud assembly parsing, application graph, provider interfaces, SDK redirection
  - **Runtime & Providers**: Lambda runtime, API Gateway, DynamoDB, SQS, S3, SNS, EventBridge, Step Functions, ECS, Cognito
  - **Developer Experience**: hot reload, validation engine, configuration, logging
- Each capability has requirements with testable scenarios
- Requirements use SHALL/MUST language per openspec conventions

## Impact
- Affected specs: all new (19 capabilities)
- Affected code: none yet (greenfield project)
- This proposal establishes the baseline requirements for LDK Phases 0 through 2
