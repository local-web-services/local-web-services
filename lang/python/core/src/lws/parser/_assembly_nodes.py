"""Domain model dataclasses for the CDK assembly parser.

All dataclasses representing parsed AWS resources live here so that
``assembly.py`` can stay focused on orchestration logic.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from pathlib import Path
from typing import Any


@dataclass
class LambdaFunction:
    """Parsed Lambda function ready for local execution."""

    name: str
    handler: str
    runtime: str
    code_path: Path | None = None
    timeout: int = 30
    memory: int = 128
    environment: dict[str, str] = field(default_factory=dict)

    @property
    def logical_id(self) -> str:
        """Return the function name as its logical identifier."""
        return self.name


@dataclass
class DynamoTable:
    """Parsed DynamoDB table definition."""

    name: str
    key_schema: list[dict[str, str]] = field(default_factory=list)
    gsi_definitions: list[dict[str, Any]] = field(default_factory=list)

    @property
    def logical_id(self) -> str:
        """Return the table name as its logical identifier."""
        return self.name

    @property
    def table_name(self) -> str:
        """Return the DynamoDB table name."""
        return self.name


@dataclass
class ApiRoute:
    """A single API Gateway route."""

    method: str
    path: str
    handler_name: str | None = None


@dataclass
class ApiDefinition:
    """A collection of routes making up an API."""

    name: str = "default"
    routes: list[ApiRoute] = field(default_factory=list)

    @property
    def logical_id(self) -> str:
        """Return the API name as its logical identifier."""
        return self.name


@dataclass
class SqsQueue:
    """Parsed SQS queue definition."""

    name: str
    is_fifo: bool = False
    visibility_timeout: int = 30
    content_based_dedup: bool = False
    redrive_target: str | None = None
    max_receive_count: int = 5


@dataclass
class S3Bucket:
    """Parsed S3 bucket definition."""

    name: str
    website_configuration: dict[str, Any] | None = None


@dataclass
class SnsTopic:
    """Parsed SNS topic definition."""

    name: str
    topic_arn: str = ""


@dataclass
class EventBus:
    """Parsed EventBridge event bus definition."""

    name: str
    bus_arn: str = ""


@dataclass
class EventRule:
    """Parsed EventBridge rule definition."""

    rule_name: str
    event_bus_name: str = "default"
    event_pattern: dict[str, Any] | None = None
    schedule_expression: str | None = None
    targets: list[dict[str, Any]] = field(default_factory=list)


@dataclass
class StateMachine:
    """Parsed Step Functions state machine definition."""

    name: str
    definition: str | dict[str, Any] = ""
    workflow_type: str = "STANDARD"
    role_arn: str = ""
    definition_substitutions: dict[str, str] = field(default_factory=dict)


@dataclass
class CognitoUserPool:
    """Parsed Cognito user pool definition."""

    logical_id: str
    user_pool_name: str = "default"
    auto_confirm: bool = True
    password_policy: dict[str, Any] = field(default_factory=dict)
    pre_auth_trigger: str | None = None
    post_confirm_trigger: str | None = None
    client_id: str = ""


@dataclass
class SsmParameter:
    """Parsed SSM Parameter Store parameter."""

    name: str
    type: str  # "String", "StringList", "SecureString"
    value: str
    description: str = ""


@dataclass
class SmSecret:
    """Parsed Secrets Manager secret."""

    name: str
    description: str = ""
    secret_string: str | None = None


@dataclass
class LambdaFunctionUrl:
    """Parsed Lambda Function URL definition."""

    logical_id: str
    function_name: str
    auth_type: str = "NONE"
    cors: dict[str, Any] | None = None
    invoke_mode: str = "BUFFERED"


@dataclass
class AppModel:
    """Complete parsed representation of a CDK application."""

    functions: list[LambdaFunction] = field(default_factory=list)
    tables: list[DynamoTable] = field(default_factory=list)
    apis: list[ApiDefinition] = field(default_factory=list)
    queues: list[SqsQueue] = field(default_factory=list)
    buckets: list[S3Bucket] = field(default_factory=list)
    topics: list[SnsTopic] = field(default_factory=list)
    event_buses: list[EventBus] = field(default_factory=list)
    event_rules: list[EventRule] = field(default_factory=list)
    state_machines: list[StateMachine] = field(default_factory=list)
    user_pools: list[CognitoUserPool] = field(default_factory=list)
    ecs_services: list[Any] = field(default_factory=list)
    ssm_parameters: list[SsmParameter] = field(default_factory=list)
    secrets: list[SmSecret] = field(default_factory=list)
    function_urls: list[LambdaFunctionUrl] = field(default_factory=list)
