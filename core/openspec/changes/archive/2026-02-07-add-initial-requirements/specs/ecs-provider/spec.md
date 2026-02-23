## ADDED Requirements

### Requirement: Long-Running Process Execution
The ECS provider SHALL run ECS task definitions as long-running local processes.

#### Scenario: Start ECS service
- **WHEN** the CDK defines an ECS service with a container image and command
- **THEN** LDK SHALL start the service as a local process that runs continuously until stopped

### Requirement: Health Check Polling
The provider SHALL poll the health check endpoint configured in the ECS task definition to determine service readiness.

#### Scenario: Health check succeeds
- **WHEN** an ECS service has a health check configured at `/health` and the service responds with HTTP 200
- **THEN** the service SHALL be marked as healthy and available

#### Scenario: Health check fails
- **WHEN** the health check endpoint returns a non-200 status or times out
- **THEN** the service SHALL be marked as unhealthy in the terminal output

### Requirement: Graceful Restart on Code Changes
The provider SHALL gracefully restart ECS service processes when code changes are detected, sending SIGTERM, waiting for graceful shutdown, and then SIGKILL if the process does not exit.

#### Scenario: Code change triggers restart
- **WHEN** a developer modifies the source code of an ECS service while `ldk dev` is running
- **THEN** the running process SHALL receive SIGTERM, be given time to shut down gracefully, and be restarted with the updated code

### Requirement: Service Discovery
The provider SHALL register local endpoints for ECS services so that other services in the application can discover and connect to them.

#### Scenario: Service discoverable by other handlers
- **WHEN** an ECS service is running locally and a Lambda handler needs to call it
- **THEN** the service's local endpoint SHALL be discoverable via the same mechanism used in AWS (e.g., environment variables or DNS-like resolution)

### Requirement: Load Balancer Integration
The provider SHALL support ECS services behind an Application Load Balancer by routing HTTP requests through the local HTTP server to the ECS service process.

#### Scenario: ALB routes to ECS service
- **WHEN** the CDK defines an ECS service behind an ALB with path-based routing
- **THEN** HTTP requests matching the configured path pattern SHALL be routed to the local ECS service process
