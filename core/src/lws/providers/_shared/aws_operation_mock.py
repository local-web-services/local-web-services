"""AWS operation-level mocking middleware.

Intercepts requests matching user-defined mock rules and returns canned
responses.  Rules are matched by operation name (CLI-style kebab-case)
and optional header filters.  The middleware sits before the chaos
middleware so mocked operations never reach the real provider.
"""

from __future__ import annotations

import asyncio
import json
import re
from dataclasses import dataclass, field
from typing import Any
from urllib.parse import parse_qs

from starlette.middleware.base import BaseHTTPMiddleware, RequestResponseEndpoint
from starlette.requests import Request
from starlette.responses import Response

# ------------------------------------------------------------------
# Data models
# ------------------------------------------------------------------


@dataclass
class AwsMockResponse:
    """Canned response returned when a mock rule matches."""

    status: int = 200
    headers: dict[str, str] = field(default_factory=dict)
    body: Any = None
    content_type: str = "application/json"
    delay_ms: int = 0


@dataclass
class AwsMockRule:
    """A single mock rule: operation + optional header filter + response."""

    operation: str
    match_headers: dict[str, str] = field(default_factory=dict)
    response: AwsMockResponse = field(default_factory=AwsMockResponse)


@dataclass
class AwsMockConfig:
    """Mock configuration for one AWS service."""

    service: str
    enabled: bool = True
    rules: list[AwsMockRule] = field(default_factory=list)


# ------------------------------------------------------------------
# CamelCase / PascalCase to kebab-case normalizer
# ------------------------------------------------------------------


def camel_to_kebab(name: str) -> str:
    """Convert ``GetItem`` or ``ListObjectsV2`` to ``get-item`` / ``list-objects-v2``."""
    result = re.sub(r"([A-Z]+)([A-Z][a-z])", r"\1-\2", name)
    result = re.sub(r"([a-z0-9])([A-Z])", r"\1-\2", result)
    return result.lower()


# ------------------------------------------------------------------
# Operation extractors
# ------------------------------------------------------------------

OperationExtractor = Any  # callable (Request, bytes) -> str | None


def _extractor_json_target(prefix: str):  # noqa: ANN202
    """Factory: extract operation from ``X-Amz-Target`` header with *prefix*."""

    def _extract(request: Request, _body: bytes) -> str | None:
        target = request.headers.get("x-amz-target", "")
        if not target.startswith(prefix):
            return None
        raw = target[len(prefix) :]
        return camel_to_kebab(raw)

    return _extract


def _extractor_form_action():  # noqa: ANN202
    """Extract operation from ``Action`` form field or query param."""

    def _extract(request: Request, body: bytes) -> str | None:
        action = request.query_params.get("Action")
        if not action:
            content_type = request.headers.get("content-type", "")
            if "application/x-www-form-urlencoded" in content_type:
                parsed = parse_qs(body.decode("utf-8", errors="replace"))
                vals = parsed.get("Action", [])
                if vals:
                    action = vals[0]
        if action:
            return camel_to_kebab(action)
        return None

    return _extract


def _extractor_sqs_dual():  # noqa: ANN202
    """SQS: try JSON target first, fall back to form action."""
    json_ext = _extractor_json_target("AmazonSQS.")
    form_ext = _extractor_form_action()

    def _extract(request: Request, body: bytes) -> str | None:
        result = json_ext(request, body)
        if result is not None:
            return result
        return form_ext(request, body)

    return _extract


def _extractor_s3_rest():  # noqa: ANN202
    """S3: map (method, path, query params, headers) to operation name."""

    def _extract(request: Request, _body: bytes) -> str | None:
        method = request.method.upper()
        path = request.url.path
        segments = [s for s in path.split("/") if s]
        num_segments = len(segments)
        qp = set(request.query_params.keys())

        if num_segments == 0:
            if method == "GET":
                return "list-buckets"
            return None

        if num_segments == 1:
            return _s3_bucket_op(method, qp)

        return _s3_object_op(method, qp, request)

    return _extract


def _s3_bucket_op(method: str, qp: set[str]) -> str | None:
    bucket_ops = {
        ("GET", "location"): "get-bucket-location",
        ("GET", "tagging"): "get-bucket-tagging",
        ("PUT", "tagging"): "put-bucket-tagging",
        ("DELETE", "tagging"): "delete-bucket-tagging",
        ("GET", "policy"): "get-bucket-policy",
        ("PUT", "policy"): "put-bucket-policy",
        ("GET", "notification"): "get-bucket-notification-configuration",
        ("PUT", "notification"): "put-bucket-notification-configuration",
        ("GET", "website"): "get-bucket-website",
        ("PUT", "website"): "put-bucket-website",
        ("DELETE", "website"): "delete-bucket-website",
        ("GET", "versioning"): "get-bucket-versioning",
        ("GET", "acl"): "get-bucket-acl",
        ("POST", "delete"): "delete-objects",
    }
    for (m, param), op in bucket_ops.items():
        if method == m and param in qp:
            return op

    simple_ops = {
        "PUT": "create-bucket",
        "DELETE": "delete-bucket",
        "HEAD": "head-bucket",
        "GET": "list-objects-v2",
    }
    return simple_ops.get(method)


def _s3_object_op(method: str, qp: set[str], request: Request) -> str | None:
    dispatch = {
        "PUT": lambda: _s3_object_put(qp, request),
        "POST": lambda: _s3_object_post(qp),
        "GET": lambda: "list-parts" if "uploadId" in qp else "get-object",
        "DELETE": lambda: ("abort-multipart-upload" if "uploadId" in qp else "delete-object"),
        "HEAD": lambda: "head-object",
    }
    handler = dispatch.get(method)
    return handler() if handler else None


def _s3_object_put(qp: set[str], request: Request) -> str:
    if "partNumber" in qp and "uploadId" in qp:
        return "upload-part"
    if "x-amz-copy-source" in request.headers:
        return "copy-object"
    return "put-object"


def _s3_object_post(qp: set[str]) -> str | None:
    if "uploads" in qp:
        return "create-multipart-upload"
    if "uploadId" in qp:
        return "complete-multipart-upload"
    return None


SERVICE_EXTRACTORS: dict[str, OperationExtractor] = {
    "dynamodb": _extractor_json_target("DynamoDB_20120810."),
    "sqs": _extractor_sqs_dual(),
    "sns": _extractor_form_action(),
    "events": _extractor_json_target("AWSEvents."),
    "stepfunctions": _extractor_json_target("AWSStepFunctions."),
    "cognito-idp": _extractor_json_target("AWSCognitoIdentityProviderService."),
    "ssm": _extractor_json_target("AmazonSSM."),
    "secretsmanager": _extractor_json_target("secretsmanager."),
    "s3": _extractor_s3_rest(),
}


# ------------------------------------------------------------------
# Shared operation extraction
# ------------------------------------------------------------------


async def extract_operation_from_request(
    request: Request,
    service: str,
) -> str | None:
    """Extract the AWS operation name from a request, or None if not possible.

    Skips internal ``/_ldk/`` paths and returns None when no extractor
    is registered for the service or the extractor cannot determine the
    operation.
    """
    if request.url.path.startswith("/_ldk/"):
        return None
    extractor = SERVICE_EXTRACTORS.get(service)
    if extractor is None:
        return None
    body = await request.body()
    return extractor(request, body)


# ------------------------------------------------------------------
# Middleware
# ------------------------------------------------------------------


class AwsOperationMockMiddleware(BaseHTTPMiddleware):
    """Return canned responses for requests matching mock rules."""

    def __init__(
        self,
        app,  # noqa: ANN001
        mock_config: AwsMockConfig,
        service: str,
    ) -> None:
        super().__init__(app)
        self.mock_config = mock_config
        self.service = service

    async def dispatch(  # pylint: disable=missing-function-docstring
        self, request: Request, call_next: RequestResponseEndpoint
    ) -> Response:
        if not self.mock_config.enabled:
            return await call_next(request)

        operation = await extract_operation_from_request(request, self.service)
        if operation is None:
            return await call_next(request)

        matched = _find_matching_rule(operation, request, self.mock_config.rules)
        if matched is None:
            return await call_next(request)

        return await _build_response(matched.response)


def _find_matching_rule(
    operation: str,
    request: Request,
    rules: list[AwsMockRule],
) -> AwsMockRule | None:
    """Scan rules in order; return first match or None."""
    for rule in rules:
        if rule.operation != operation:
            continue
        if rule.match_headers:
            if not _headers_match(request, rule.match_headers):
                continue
        return rule
    return None


def _headers_match(request: Request, match_headers: dict[str, str]) -> bool:
    """Return True if all match_headers are present with exact values."""
    for key, expected in match_headers.items():
        actual = request.headers.get(key.lower(), "")
        if actual != expected:
            return False
    return True


async def _build_response(mock_resp: AwsMockResponse) -> Response:
    """Build a Starlette Response from an AwsMockResponse."""
    if mock_resp.delay_ms > 0:
        await asyncio.sleep(mock_resp.delay_ms / 1000.0)

    body = mock_resp.body
    if body is not None and not isinstance(body, (str, bytes)):
        body = json.dumps(body)
    if isinstance(body, str):
        body = body.encode("utf-8")

    headers = dict(mock_resp.headers)

    return Response(
        content=body or b"",
        status_code=mock_resp.status,
        media_type=mock_resp.content_type,
        headers=headers,
    )


# ------------------------------------------------------------------
# Config parsing
# ------------------------------------------------------------------


def parse_mock_response(raw: dict[str, Any]) -> AwsMockResponse:
    """Parse a raw response dict into an AwsMockResponse."""
    body = raw.get("body")
    return AwsMockResponse(
        status=int(raw.get("status", 200)),
        headers=dict(raw.get("headers", {})),
        body=body,
        content_type=str(raw.get("content_type", "application/json")),
        delay_ms=int(raw.get("delay_ms", 0)),
    )


def parse_mock_rule(raw: dict[str, Any]) -> AwsMockRule:
    """Parse a raw rule dict into an AwsMockRule."""
    match_raw = raw.get("match", {})
    match_headers = dict(match_raw.get("headers", {}))
    response = parse_mock_response(raw.get("response", {}))
    return AwsMockRule(
        operation=raw.get("operation", ""),
        match_headers=match_headers,
        response=response,
    )


def parse_aws_mock_config(raw: dict[str, Any]) -> AwsMockConfig:
    """Parse a raw config dict into an AwsMockConfig."""
    rules: list[AwsMockRule] = []
    for rule_raw in raw.get("rules", []):
        rules.append(parse_mock_rule(rule_raw))
    return AwsMockConfig(
        service=raw.get("service", ""),
        enabled=raw.get("enabled", True),
        rules=rules,
    )
