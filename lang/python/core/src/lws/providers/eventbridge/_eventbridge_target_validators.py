"""Cross-service target validation for EventBridge PutTargets and PutEvents."""

from __future__ import annotations

import json

from fastapi import Response

from lws.providers._shared.aws_lifecycle import ResourceStateTracker
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.lambda_runtime._lambda_registry import LambdaRegistry
from lws.providers.sns.provider import SnsProvider
from lws.providers.sqs.provider import SqsProvider


def _check_sqs_targets(
    body: dict,
    sqs_provider: SqsProvider,
    sqs_tracker: ResourceStateTracker | None,
) -> Response | None:
    """Return an error response if any SQS target queue does not exist or is not ACTIVE."""
    for t in body.get("Targets", []):
        arn = t.get("Arn", "")
        if ":sqs:" not in arn:
            continue
        queue_name = arn.rsplit(":", 1)[-1]
        queue = sqs_provider.get_queue(queue_name)
        if queue is None:
            return Response(
                content=json.dumps({"Error": f"SQS queue does not exist: {arn}"}),
                status_code=400,
                media_type="application/json",
            )
        if sqs_tracker is not None:
            state = sqs_tracker.get_state(queue_name)
            if state in ("CREATING", "DELETING"):
                return Response(
                    content=json.dumps(
                        {"Error": f"SQS queue is not ACTIVE: {arn} (status: {state})"}
                    ),
                    status_code=400,
                    media_type="application/json",
                )
    return None


def _check_sns_targets(
    body: dict,
    sns_provider: SnsProvider,
    sns_tracker: ResourceStateTracker | None,
) -> Response | None:
    """Return an error response if any SNS target topic does not exist or is not ACTIVE."""
    for t in body.get("Targets", []):
        arn = t.get("Arn", "")
        if ":sns:" not in arn:
            continue
        topic_name = arn.rsplit(":", 1)[-1]
        topic = None
        try:
            topic = sns_provider.get_topic(topic_name)
        except (KeyError, Exception):  # noqa: BLE001
            topic = None
        if topic is None:
            return Response(
                content=json.dumps({"Error": f"SNS topic does not exist: {arn}"}),
                status_code=400,
                media_type="application/json",
            )
        if sns_tracker is not None:
            state = sns_tracker.get_state(topic_name)
            if state in ("CREATING", "DELETING"):
                return Response(
                    content=json.dumps(
                        {"Error": f"SNS topic is not ACTIVE: {arn} (status: {state})"}
                    ),
                    status_code=400,
                    media_type="application/json",
                )
    return None


def _check_lambda_targets(
    body: dict,
    lambda_registry: LambdaRegistry,
    lambda_tracker: ResourceStateTracker | None,
) -> Response | None:
    """Return an error response if any Lambda target function does not exist or is not ACTIVE."""
    for t in body.get("Targets", []):
        arn = t.get("Arn", "")
        if ":function:" not in arn:
            continue
        func_name = arn.rsplit(":", 1)[-1]
        if lambda_registry.get_config(func_name) is None:
            return Response(
                content=json.dumps({"Error": f"Lambda function does not exist: {arn}"}),
                status_code=400,
                media_type="application/json",
            )
        if lambda_tracker is not None:
            state = lambda_tracker.get_state(func_name)
            if state in ("CREATING", "DELETING"):
                return Response(
                    content=json.dumps(
                        {"Error": f"Lambda function is not ACTIVE: {arn} (status: {state})"}
                    ),
                    status_code=400,
                    media_type="application/json",
                )
    return None


def _check_dynamodb_targets(
    body: dict,
    dynamodb_provider: SqliteDynamoProvider,
    dynamodb_tracker: ResourceStateTracker | None,
) -> Response | None:
    """Return an error response if any DynamoDB target table does not exist or is not ACTIVE."""
    for t in body.get("Targets", []):
        arn = t.get("Arn", "")
        if ":dynamodb:" not in arn or ":table/" not in arn:
            continue
        table_name = arn.rsplit("/", 1)[-1]
        if not dynamodb_provider.has_table(table_name):
            return Response(
                content=json.dumps({"Error": f"DynamoDB table does not exist: {arn}"}),
                status_code=400,
                media_type="application/json",
            )
        if dynamodb_tracker is not None:
            state = dynamodb_tracker.get_state(table_name)
            if state in ("CREATING", "DELETING"):
                return Response(
                    content=json.dumps(
                        {"Error": f"DynamoDB table is not ACTIVE: {arn} (status: {state})"}
                    ),
                    status_code=400,
                    media_type="application/json",
                )
    return None


def _check_put_targets_validation(
    target: str,
    body: dict,
    sqs_provider: SqsProvider | None,
    sqs_tracker: ResourceStateTracker | None,
    sns_provider: SnsProvider | None,
    sns_tracker: ResourceStateTracker | None,
    lambda_registry: LambdaRegistry | None = None,
    lambda_tracker: ResourceStateTracker | None = None,
    dynamodb_provider: SqliteDynamoProvider | None = None,
    dynamodb_tracker: ResourceStateTracker | None = None,
) -> Response | None:
    """Validate SQS, SNS, Lambda, and DynamoDB targets when PutTargets is called."""
    if target != "AWSEvents.PutTargets":
        return None
    if sqs_provider is not None:
        err = _check_sqs_targets(body, sqs_provider, sqs_tracker)
        if err is not None:
            return err
    if sns_provider is not None:
        err = _check_sns_targets(body, sns_provider, sns_tracker)
        if err is not None:
            return err
    if lambda_registry is not None:
        err = _check_lambda_targets(body, lambda_registry, lambda_tracker)
        if err is not None:
            return err
    if dynamodb_provider is not None:
        return _check_dynamodb_targets(body, dynamodb_provider, dynamodb_tracker)
    return None
