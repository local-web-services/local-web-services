"""Chaos engineering middleware for AWS service providers.

Injects errors, latency, timeouts, and connection resets based on
``AwsChaosConfig``.  Each AWS service specifies its error format
(JSON, S3-XML, or IAM-XML) so that injected errors look like real
AWS responses.
"""

from __future__ import annotations

import asyncio
import json
import random
from dataclasses import dataclass, field
from enum import Enum
from typing import Any

from starlette.middleware.base import BaseHTTPMiddleware, RequestResponseEndpoint
from starlette.requests import Request
from starlette.responses import Response

from lws.providers._shared.chaos_helpers import apply_chaos_latency, should_inject_error

# ------------------------------------------------------------------
# Data models
# ------------------------------------------------------------------


@dataclass
class AwsErrorSpec:
    """A single error type that chaos can inject."""

    type: str
    message: str
    weight: float = 1.0
    status_code: int | None = None


@dataclass
class AwsChaosConfig:
    """Chaos engineering configuration for an AWS service provider."""

    enabled: bool = False
    error_rate: float = 0.0
    latency_min_ms: int = 0
    latency_max_ms: int = 0
    errors: list[AwsErrorSpec] = field(default_factory=list)
    connection_reset_rate: float = 0.0
    timeout_rate: float = 0.0


# ------------------------------------------------------------------
# Error format enum
# ------------------------------------------------------------------


class ErrorFormat(Enum):
    """Response format for AWS error responses."""

    JSON = "json"
    XML_S3 = "xml_s3"
    XML_IAM = "xml_iam"


# ------------------------------------------------------------------
# AWS error status code registry
# ------------------------------------------------------------------

AWS_ERROR_STATUS_CODES: dict[str, int] = {
    # Generic
    "AccessDeniedException": 403,
    "InvalidParameterException": 400,
    "InvalidParameterValueException": 400,
    "ValidationException": 400,
    "DuplicateResourceException": 409,
    "LimitExceededException": 429,
    "ResourceNotFoundException": 404,
    "ResourceNotFoundFault": 404,
    "InvalidStateException": 409,
    "ServiceUnavailableException": 503,
    "InternalServerError": 500,
    "ThrottlingException": 429,
    # IAM / STS
    "NoSuchEntityException": 404,
    "NoSuchEntity": 404,
    "MalformedPolicyDocumentException": 400,
    "MalformedPolicyDocument": 400,
    "EntityAlreadyExistsException": 409,
    "EntityAlreadyExists": 409,
    "PasswordPolicyViolationException": 400,
    # S3
    "NoSuchKey": 404,
    "NoSuchBucket": 404,
    "BucketAlreadyExists": 409,
    "BucketAlreadyOwnedByYou": 409,
    "AccessDenied": 403,
    # DynamoDB
    "ConditionalCheckFailedException": 400,
    "ProvisionedThroughputExceededException": 400,
    "ItemCollectionSizeLimitExceededException": 400,
    # SQS
    "QueueDoesNotExist": 400,
    "QueueNameExists": 400,
    # Cognito
    "UserNotFoundException": 404,
    "UsernameExistsException": 400,
    "NotAuthorizedException": 401,
    # Step Functions
    "StateMachineDoesNotExist": 400,
    "ExecutionDoesNotExist": 400,
    # SNS
    "NotFoundException": 404,
    # EventBridge
    "ResourceAlreadyExistsException": 409,
}


# ------------------------------------------------------------------
# Error formatters
# ------------------------------------------------------------------


def _resolve_status_code(error: AwsErrorSpec) -> int:
    """Return the HTTP status code for an error spec."""
    if error.status_code is not None:
        return error.status_code
    return AWS_ERROR_STATUS_CODES.get(error.type, 400)


def format_json_error(error: AwsErrorSpec) -> Response:
    """Format an AWS JSON error response (DynamoDB, Cognito, SSM, etc.)."""
    status = _resolve_status_code(error)
    body = json.dumps({"__type": error.type, "message": error.message})
    return Response(
        content=body,
        status_code=status,
        media_type="application/x-amz-json-1.0",
    )


def format_s3_xml_error(error: AwsErrorSpec) -> Response:
    """Format an S3-style XML error response."""
    status = _resolve_status_code(error)
    xml = (
        "<?xml version='1.0' encoding='UTF-8'?>"
        "<Error>"
        f"<Code>{error.type}</Code>"
        f"<Message>{error.message}</Message>"
        "<Resource>/</Resource>"
        "<RequestId>00000000-0000-0000-0000-000000000000</RequestId>"
        "</Error>"
    )
    return Response(content=xml, status_code=status, media_type="application/xml")


def format_iam_xml_error(error: AwsErrorSpec) -> Response:
    """Format an IAM/STS-style XML error response."""
    status = _resolve_status_code(error)
    xml = (
        "<ErrorResponse>"
        "<Error>"
        "<Type>Sender</Type>"
        f"<Code>{error.type}</Code>"
        f"<Message>{error.message}</Message>"
        "</Error>"
        "<RequestId>00000000-0000-0000-0000-000000000000</RequestId>"
        "</ErrorResponse>"
    )
    return Response(content=xml, status_code=status, media_type="text/xml")


_FORMAT_DISPATCH = {
    ErrorFormat.JSON: format_json_error,
    ErrorFormat.XML_S3: format_s3_xml_error,
    ErrorFormat.XML_IAM: format_iam_xml_error,
}


def format_error(error: AwsErrorSpec, fmt: ErrorFormat) -> Response:
    """Format an error response in the given format."""
    return _FORMAT_DISPATCH[fmt](error)


# ------------------------------------------------------------------
# Middleware
# ------------------------------------------------------------------


class AwsChaosMiddleware(BaseHTTPMiddleware):
    """Starlette middleware that injects chaos into AWS service responses."""

    def __init__(
        self,
        app,  # noqa: ANN001
        chaos_config: AwsChaosConfig,
        error_format: ErrorFormat,
    ) -> None:
        super().__init__(app)
        self.chaos = chaos_config
        self.error_format = error_format

    async def dispatch(self, request: Request, call_next: RequestResponseEndpoint) -> Response:
        """Apply chaos rules before forwarding the request."""
        if not self.chaos.enabled:
            return await call_next(request)

        if request.url.path.startswith("/_ldk/"):
            return await call_next(request)

        # Connection reset
        if self.chaos.connection_reset_rate > 0:
            if random.random() < self.chaos.connection_reset_rate:
                raise ConnectionResetError("chaos: connection reset")

        # Timeout simulation
        if self.chaos.timeout_rate > 0:
            if random.random() < self.chaos.timeout_rate:
                await asyncio.sleep(300)
                timeout_error = AwsErrorSpec(
                    type="ServiceUnavailableException",
                    message="chaos: request timed out",
                    status_code=504,
                )
                return format_error(timeout_error, self.error_format)

        # Latency injection
        await apply_chaos_latency(self.chaos.latency_min_ms, self.chaos.latency_max_ms)

        # Error rate injection
        if should_inject_error(self.chaos.error_rate):
            error = _pick_error(self.chaos)
            return format_error(error, self.error_format)

        return await call_next(request)


def _pick_error(chaos: AwsChaosConfig) -> AwsErrorSpec:
    """Pick an error based on weighted errors config."""
    if not chaos.errors:
        return AwsErrorSpec(
            type="InternalServerError",
            message="chaos: injected error",
            status_code=500,
        )
    roll = random.random()
    cumulative = 0.0
    total_weight = sum(e.weight for e in chaos.errors)
    for error in chaos.errors:
        cumulative += error.weight / total_weight if total_weight > 0 else 0
        if roll < cumulative:
            return error
    return chaos.errors[-1]


# ------------------------------------------------------------------
# Config parsing
# ------------------------------------------------------------------


def parse_chaos_config(raw: dict[str, Any]) -> AwsChaosConfig:
    """Parse a raw config dict into an AwsChaosConfig."""
    errors: list[AwsErrorSpec] = []
    for err_raw in raw.get("errors", []):
        errors.append(
            AwsErrorSpec(
                type=err_raw.get("type", "InternalServerError"),
                message=err_raw.get("message", "chaos: injected error"),
                weight=float(err_raw.get("weight", 1.0)),
                status_code=err_raw.get("status_code"),
            )
        )

    return AwsChaosConfig(
        enabled=raw.get("enabled", False),
        error_rate=float(raw.get("error_rate", 0.0)),
        latency_min_ms=int(raw.get("latency_min_ms", 0)),
        latency_max_ms=int(raw.get("latency_max_ms", 0)),
        errors=errors,
        connection_reset_rate=float(raw.get("connection_reset_rate", 0.0)),
        timeout_rate=float(raw.get("timeout_rate", 0.0)),
    )
