"""Typed resource spec dataclasses for LwsSession."""

from __future__ import annotations

from dataclasses import dataclass


@dataclass
class DynamoTable:
    """A DynamoDB table resource.

    Args:
        name: Table name.
        hash_key: Partition key attribute name.
        hash_key_type: Partition key attribute type (default: ``"S"``).
        sort_key: Sort key attribute name, or ``None`` for a simple key.
        sort_key_type: Sort key attribute type (default: ``"S"``).
    """

    name: str
    hash_key: str
    hash_key_type: str = "S"
    sort_key: str | None = None
    sort_key_type: str = "S"


@dataclass
class SqsQueue:
    """An SQS queue resource.

    Args:
        name: Queue name.
        visibility_timeout: Visibility timeout in seconds (default: ``30``).
        is_fifo: Whether this is a FIFO queue (default: ``False``).
    """

    name: str
    visibility_timeout: int = 30
    is_fifo: bool = False


@dataclass
class S3Bucket:
    """An S3 bucket resource.

    Args:
        name: Bucket name.
    """

    name: str


@dataclass
class SnsTopic:
    """An SNS topic resource.

    Args:
        name: Topic name.
    """

    name: str


@dataclass
class SsmParameter:
    """An SSM Parameter Store parameter.

    Args:
        name: Parameter name (including leading ``/`` if applicable).
    """

    name: str


@dataclass
class Secret:
    """A Secrets Manager secret.

    Args:
        name: Secret name.
    """

    name: str


@dataclass
class StateMachine:
    """A Step Functions state machine.

    Args:
        name: State machine name.
        definition: ASL definition as a JSON string.
        role_arn: IAM role ARN (default: test role ARN).
    """

    name: str
    definition: str
    role_arn: str = "arn:aws:iam::000000000000:role/StepFunctionsRole"
