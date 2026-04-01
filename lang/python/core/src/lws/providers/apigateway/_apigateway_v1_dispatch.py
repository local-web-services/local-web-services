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


def _check_capacity(capacity: Any, slot_err_msg: str) -> None:
    """Raise ValueError when the capacity config is exhausted."""
    if capacity is not None and capacity.is_exhausted:
        raise ValueError(slot_err_msg)


def _check_resource_lifecycle(tracker: Any, resource_type: str, resource_name: str) -> None:
    """Raise ValueError when the tracker shows the resource is not ACTIVE."""
    if tracker is None or not resource_name:
        return
    state = tracker.get_state(resource_name)
    if state is not None and state != "ACTIVE":
        raise ValueError(f"{resource_type} '{resource_name}' is not ACTIVE (current: {state})")


async def _dispatch_dynamodb(
    service_descriptor: dict[str, Any], request_body: dict, service_providers: dict[str, Any]
) -> dict:
    """Dispatch a DynamoDB integration action."""
    provider = service_providers.get("dynamodb")
    if provider is None:
        raise ValueError("No DynamoDB provider configured")
    _check_capacity(service_providers.get("dynamodb_capacity"), "lws: no item slots available")
    table_name = request_body.get("TableName", "")
    _check_resource_lifecycle(
        service_providers.get("dynamodb_tracker"), "DynamoDB table", table_name
    )
    action = service_descriptor["action"]
    if action == "PutItem":
        await provider.put_item(table_name=table_name, item=request_body.get("Item", {}))
        return {}
    if action == "GetItem":
        item = await provider.get_item(table_name=table_name, key=request_body.get("Key", {}))
        return {"Item": item} if item else {}
    raise ValueError(f"Unsupported DynamoDB action: {action}")


async def _dispatch_sqs(
    service_descriptor: dict[str, Any], request_body: dict, service_providers: dict[str, Any]
) -> dict:
    """Dispatch an SQS integration action."""
    provider = service_providers.get("sqs")
    if provider is None:
        raise ValueError("No SQS provider configured")

    capacity = service_providers.get("sqs_capacity")
    if capacity is not None and capacity.is_exhausted:
        raise ValueError("lws: no message slots available")

    queue_name = service_descriptor["queue"]
    sqs_tracker = service_providers.get("sqs_tracker")
    if sqs_tracker is not None:
        queue_state = sqs_tracker.get_state(queue_name)
        if queue_state is not None and queue_state != "ACTIVE":
            raise ValueError(f"SQS queue '{queue_name}' is not ACTIVE (current: {queue_state})")

    message_body = json.dumps(request_body) if isinstance(request_body, dict) else str(request_body)
    message_id = await provider.send_message(queue_name=queue_name, message_body=message_body)
    return {"MessageId": message_id}


async def _dispatch_sns(request_body: dict, service_providers: dict[str, Any]) -> dict:
    """Dispatch an SNS integration action."""
    provider = service_providers.get("sns")
    if provider is None:
        raise ValueError("No SNS provider configured")

    capacity = service_providers.get("sns_capacity")
    if capacity is not None and capacity.is_exhausted:
        raise ValueError("lws: no message slots available")

    topic_name = request_body.get("TopicArn", "").rsplit(":", 1)[-1]
    sns_tracker = service_providers.get("sns_tracker")
    if sns_tracker is not None and topic_name:
        topic_state = sns_tracker.get_state(topic_name)
        if topic_state is not None and topic_state != "ACTIVE":
            raise ValueError(f"SNS topic '{topic_name}' is not ACTIVE (current: {topic_state})")

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

    s3_tracker = service_providers.get("s3_tracker")
    if s3_tracker is not None:
        bucket_state = s3_tracker.get_state(bucket)
        if bucket_state is not None and bucket_state != "ACTIVE":
            raise ValueError(f"S3 bucket '{bucket}' is not ACTIVE (current: {bucket_state})")

    key = service_descriptor["key"]
    body_bytes = json.dumps(request_body).encode() if isinstance(request_body, dict) else b""
    await provider.put_object(bucket_name=bucket, key=key, body=body_bytes)
    return {}


async def _dispatch_states(request_body: dict, service_providers: dict[str, Any]) -> dict:
    """Dispatch a StepFunctions integration action."""
    provider = service_providers.get("stepfunctions")
    if provider is None:
        raise ValueError("No StepFunctions provider configured")

    capacity = service_providers.get("stepfunctions_capacity")
    if capacity is not None and capacity.is_exhausted:
        raise ValueError("lws: no execution slots available")

    state_machine_arn = request_body.get("stateMachineArn", "")
    state_machine_name = state_machine_arn.rsplit(":", 1)[-1]

    sfn_tracker = service_providers.get("stepfunctions_tracker")
    if sfn_tracker is not None:
        sm_state = sfn_tracker.get_state(state_machine_name)
        if sm_state is not None and sm_state != "ACTIVE":
            raise ValueError(
                f"State machine '{state_machine_name}' is not ACTIVE (current: {sm_state})"
            )

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


def _check_resource_not_active(
    resource_type: str, resource_name: str, state: str
) -> Response | None:
    """Return a 409 response if a resource is in a non-ACTIVE state."""
    if state != "ACTIVE":
        return _json_response(
            {"message": f"{resource_type} '{resource_name}' is not ACTIVE (current: {state})"},
            status_code=409,
        )
    return None


def _validate_sqs_target(
    descriptor: dict[str, Any], service_providers: dict[str, Any]
) -> Response | None:
    sqs = service_providers.get("sqs")
    if sqs is None:
        return None
    queue_name = descriptor.get("queue", "")
    if queue_name and sqs.get_queue(queue_name) is None:
        return _json_response(
            {"message": f"SQS queue does not exist: {queue_name}"},
            status_code=400,
        )
    sqs_tracker = service_providers.get("sqs_tracker")
    if queue_name and sqs_tracker is not None:
        queue_state = sqs_tracker.get_state(queue_name)
        if queue_state is not None:
            return _check_resource_not_active("SQS queue", queue_name, queue_state)
    return None


def _validate_tracker_states(tracker: Any, resource_type: str) -> Response | None:
    for name, state in tracker.all_states().items():
        err = _check_resource_not_active(resource_type, name, state)
        if err is not None:
            return err
    return None


def _validate_s3_target(
    descriptor: dict[str, Any], service_providers: dict[str, Any]
) -> Response | None:
    s3_tracker = service_providers.get("s3_tracker")
    if s3_tracker is None:
        return None
    bucket = descriptor.get("bucket", "")
    if not bucket:
        return None
    bucket_state = s3_tracker.get_state(bucket)
    if bucket_state is not None:
        return _check_resource_not_active("S3 bucket", bucket, bucket_state)
    return None


_TRACKER_SERVICE_MAP = {
    "dynamodb": ("dynamodb_tracker", "DynamoDB table"),
    "sns": ("sns_tracker", "SNS topic"),
    "states": ("stepfunctions_tracker", "State machine"),
}


def validate_integration_target(uri: str, service_providers: dict[str, Any]) -> Response | None:
    """Return an error response if the integration target resource does not exist."""
    if is_lambda_proxy_uri(uri):
        return None
    descriptor = _parse_integration_uri(uri)
    if descriptor is None:
        return None
    service = descriptor.get("service", "")
    if service == "sqs":
        return _validate_sqs_target(descriptor, service_providers)
    if service == "s3":
        return _validate_s3_target(descriptor, service_providers)
    tracker_key, resource_type = _TRACKER_SERVICE_MAP.get(service, (None, None))
    if tracker_key is not None:
        tracker = service_providers.get(tracker_key)
        if tracker is not None:
            return _validate_tracker_states(tracker, resource_type)
    return None
