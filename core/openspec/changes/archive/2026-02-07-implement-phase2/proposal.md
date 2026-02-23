# Change: Implement Phase 2 -- Advanced Constructs

## Why
Phase 1 delivered the core local development experience (Lambda, API Gateway, DynamoDB, SQS, S3, SNS). Phase 2 adds the advanced AWS constructs that production CDK applications commonly use: EventBridge event-driven orchestration, Step Functions workflow execution, ECS long-running service support, Cognito authentication, and a validation engine that catches permission, schema, and configuration errors early in the local development loop.

## What Changes
- **EventBridge provider**: Local event bus with pattern matching, scheduled rules (croniter), and cross-service event routing
- **Step Functions provider**: ASL execution engine with recursive state walker, Task/Choice/Wait/Parallel/Map states, retry/catch, and execution tracking
- **ECS service support**: Process manager using asyncio subprocesses, health check polling, graceful restart on code changes, service discovery, and ALB integration
- **Cognito provider**: Local user pool backed by aiosqlite, JWT token generation with PyJWT/RS256, API Gateway authorizer integration, and Lambda triggers
- **Validation engine**: Pluggable Validator protocol/ABC architecture with ValidationIssue dataclasses, supporting permission validation, schema validation, environment variable validation, event shape validation, and configurable strictness levels
- **Cloud assembly parsing**: Extended for EventBridge, Step Functions, ECS, and Cognito resource types

## Impact
- Affected specs: eventbridge-provider, stepfunctions-provider, ecs-provider, cognito-provider, validation-engine
- Affected code: `ldk/providers/eventbridge/`, `ldk/providers/stepfunctions/`, `ldk/providers/ecs/`, `ldk/providers/cognito/`, `ldk/validation/`, cloud assembly parser, application graph
- Dependencies: Phase 0 and Phase 1 must be complete before implementation begins
- Sub-phases 2.1-2.4 can proceed in parallel; sub-phase 2.5 (validation) framework can start in parallel but the final integration task (P2-34) requires all providers to be complete
