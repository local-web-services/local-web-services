"""Per-service dispatch helpers for V1 REST API integration routing."""

from __future__ import annotations

import json
import re
from typing import Any

from fastapi import Response

from lws.providers.apigateway._apigateway_state import _json_response


def _parse_integration_uri(uri: str) -> dict[str, Any] | None:
    """Parse an AWS service integration URI into a service descriptor dict.

    Supported URI patterns
    ----------------------
    - ``arn:aws:apigateway:{region}:dynamodb:action/{Action}``
      → ``{"service": "dynamodb", "action": "<Action>"}``
    - ``arn:aws:apigateway:{region}:sqs:path/{account}/{queue}``
      → ``{"service": "sqs", "queue": "<queue>"}``
    - ``arn:aws:apigateway:{region}:sns:action/Publish``
      → ``{"service": "sns", "action": "Publish"}``
    - ``arn:aws:apigateway:{region}:s3:path/{bucket}/{key}``
      → ``{"service": "s3", "bucket": "<bucket>", "key": "<key>"}``
    - ``arn:aws:apigateway:{region}:states:action/StartExecution``
      → ``{"service": "states", "action": "StartExecution"}``
    - ``arn:aws:apigateway:{region}:lambda:path/2015-03-31/functions/{function_arn}/invocations``
      → ``{"service": "lambda", "function_name": "<name>"}``

    Returns ``None`` when the URI does not match any known pattern.
    """
    dynamodb_pattern = r"^arn:aws:apigateway:[^:]+:dynamodb:action/(.+)$"
    sqs_pattern = r"^arn:aws:apigateway:[^:]+:sqs:path/[^/]+/(.+)$"
    sns_pattern = r"^arn:aws:apigateway:[^:]+:sns:action/(.+)$"
    s3_pattern = r"^arn:aws:apigateway:[^:]+:s3:path/([^/]+)/(.+)$"
    states_pattern = r"^arn:aws:apigateway:[^:]+:states:action/(.+)$"
    lambda_pattern = (
        r"^arn:aws:apigateway:[^:]+:lambda:path/[^/]+/functions"
        r"/[^/]+:function:([^/]+)/invocations$"
    )

    m = re.match(dynamodb_pattern, uri)
    if m:
        return {"service": "dynamodb", "action": m.group(1)}

    m = re.match(sqs_pattern, uri)
    if m:
        return {"service": "sqs", "queue": m.group(1)}

    m = re.match(sns_pattern, uri)
    if m:
        return {"service": "sns", "action": m.group(1)}

    m = re.match(s3_pattern, uri)
    if m:
        return {"service": "s3", "bucket": m.group(1), "key": m.group(2)}

    m = re.match(states_pattern, uri)
    if m:
        return {"service": "states", "action": m.group(1)}

    m = re.match(lambda_pattern, uri)
    if m:
        return {"service": "lambda", "function_name": m.group(1)}

    return None


async def _dispatch_dynamodb(
    service_descriptor: dict[str, Any], request_body: dict, service_providers: dict[str, Any]
) -> dict:
    """Dispatch a DynamoDB integration action."""
    provider = service_providers.get("dynamodb")
    if provider is None:
        raise ValueError("No DynamoDB provider configured")
    action = service_descriptor["action"]
    if action == "PutItem":
        await provider.put_item(
            table_name=request_body.get("TableName", ""),
            item=request_body.get("Item", {}),
        )
        return {}
    if action == "GetItem":
        item = await provider.get_item(
            table_name=request_body.get("TableName", ""),
            key=request_body.get("Key", {}),
        )
        return {"Item": item} if item else {}
    raise ValueError(f"Unsupported DynamoDB action: {action}")


async def _dispatch_sqs(
    service_descriptor: dict[str, Any], request_body: dict, service_providers: dict[str, Any]
) -> dict:
    """Dispatch an SQS integration action."""
    provider = service_providers.get("sqs")
    if provider is None:
        raise ValueError("No SQS provider configured")
    queue_name = service_descriptor["queue"]
    message_body = json.dumps(request_body) if isinstance(request_body, dict) else str(request_body)
    message_id = await provider.send_message(queue_name=queue_name, message_body=message_body)
    return {"MessageId": message_id}


async def _dispatch_sns(request_body: dict, service_providers: dict[str, Any]) -> dict:
    """Dispatch an SNS integration action."""
    provider = service_providers.get("sns")
    if provider is None:
        raise ValueError("No SNS provider configured")
    topic_name = request_body.get("TopicArn", "").rsplit(":", 1)[-1]
    message = request_body.get("Message", json.dumps(request_body))
    message_id = await provider.publish(topic_name=topic_name, message=message)
    return {"MessageId": message_id}


async def _dispatch_s3(
    service_descriptor: dict[str, Any], request_body: dict, service_providers: dict[str, Any]
) -> dict:
    """Dispatch an S3 integration action."""
    provider = service_providers.get("s3")
    if provider is None:
        raise ValueError("No S3 provider configured")
    bucket = service_descriptor["bucket"]
    key = service_descriptor["key"]
    body_bytes = json.dumps(request_body).encode() if isinstance(request_body, dict) else b""
    await provider.put_object(bucket_name=bucket, key=key, body=body_bytes)
    return {}


async def _dispatch_states(request_body: dict, service_providers: dict[str, Any]) -> dict:
    """Dispatch a StepFunctions integration action."""
    provider = service_providers.get("stepfunctions")
    if provider is None:
        raise ValueError("No StepFunctions provider configured")
    state_machine_arn = request_body.get("stateMachineArn", "")
    state_machine_name = state_machine_arn.rsplit(":", 1)[-1]
    input_str = request_body.get("input", "{}")
    try:
        input_data = json.loads(input_str) if isinstance(input_str, str) else input_str
    except (json.JSONDecodeError, TypeError):
        input_data = {}
    return await provider.start_execution(
        state_machine_name=state_machine_name,
        input_data=input_data,
    )


async def _dispatch_lambda(
    service_descriptor: dict[str, Any], request_body: dict, service_providers: dict[str, Any]
) -> dict:
    """Dispatch a Lambda proxy integration synchronous invocation."""
    from lws.providers._shared.lambda_helpers import (  # pylint: disable=import-outside-toplevel
        build_default_lambda_context,
    )

    registry = service_providers.get("lambda_registry")
    if registry is None:
        raise ValueError("No Lambda registry configured")
    function_name = service_descriptor["function_name"]
    compute = registry.get_compute(function_name)
    if compute is None:
        raise ValueError(f"Lambda function not found: {function_name}")
    context = build_default_lambda_context(function_name)
    result = await compute.invoke(request_body, context)
    if result.error:
        raise ValueError(f"Lambda invocation error: {result.error}")
    return result.payload if result.payload is not None else {}


async def _dispatch_integration(
    service_descriptor: dict[str, Any],
    request_body: dict,
    service_providers: dict[str, Any],
) -> dict:
    """Dispatch a V1 REST API request to the appropriate backend service.

    Parameters
    ----------
    service_descriptor:
        Parsed integration URI descriptor from ``_parse_integration_uri``.
    request_body:
        The HTTP request body (already parsed as JSON).
    service_providers:
        Map of service-name → provider instance.

    Returns
    -------
    A dict suitable for JSON serialisation as the HTTP response body.
    Raises ``ValueError`` when the required provider is not configured.
    """
    service = service_descriptor["service"]

    if service == "dynamodb":
        return await _dispatch_dynamodb(service_descriptor, request_body, service_providers)
    if service == "sqs":
        return await _dispatch_sqs(service_descriptor, request_body, service_providers)
    if service == "sns":
        return await _dispatch_sns(request_body, service_providers)
    if service == "s3":
        return await _dispatch_s3(service_descriptor, request_body, service_providers)
    if service == "states":
        return await _dispatch_states(request_body, service_providers)
    if service == "lambda":
        return await _dispatch_lambda(service_descriptor, request_body, service_providers)

    raise ValueError(f"Unsupported service: {service}")


_LAMBDA_PROXY_PATTERN = r"^arn:aws:apigateway:[^:]+:lambda:path/.+/functions/.+/invocations$"


def is_lambda_proxy_uri(uri: str) -> bool:
    """Return True if the URI is a Lambda proxy integration URI."""
    return bool(re.match(_LAMBDA_PROXY_PATTERN, uri))


def validate_integration_target(uri: str, service_providers: dict[str, Any]) -> Response | None:
    """Return an error response if the integration target resource does not exist."""
    # Lambda proxy URIs are always valid — they don't reference a service provider.
    if is_lambda_proxy_uri(uri):
        return None
    descriptor = _parse_integration_uri(uri)
    if descriptor is None:
        return None
    service = descriptor.get("service", "")
    if service == "sqs":
        sqs = service_providers.get("sqs")
        if sqs is not None:
            queue_name = descriptor.get("queue", "")
            if queue_name and sqs.get_queue(queue_name) is None:
                return _json_response(
                    {"message": f"SQS queue does not exist: {queue_name}"},
                    status_code=400,
                )
    return None
