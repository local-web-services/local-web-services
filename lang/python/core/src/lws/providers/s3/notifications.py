"""S3 event notification dispatcher for local development."""

from __future__ import annotations

import asyncio
import json
import logging
import uuid
import xml.etree.ElementTree as ET
from collections.abc import Callable
from datetime import UTC, datetime

from lws.interfaces.compute import ICompute, LambdaContext

logger = logging.getLogger(__name__)


class NotificationDispatcher:
    """Dispatches S3-style event notifications to registered handlers.

    Supports event types like ``ObjectCreated:*`` and ``ObjectRemoved:*``
    with optional prefix/suffix key filters.

    Also supports dispatching based on bucket notification configuration XML
    to SNS, SQS, EventBridge, and Lambda targets when notification providers
    are wired in via ``set_notification_providers``.
    """

    def __init__(self) -> None:
        self._handlers: list[dict] = []
        self._config_getter: Callable[[str], str] | None = None
        self._sns_provider: object | None = None
        self._sqs_provider: object | None = None
        self._events_provider: object | None = None
        self._compute_providers: dict[str, ICompute] = {}

    def set_config_getter(self, getter: Callable[[str], str]) -> None:
        """Register a callable that returns notification config XML for a bucket."""
        self._config_getter = getter

    def set_notification_providers(
        self,
        sns_provider: object | None = None,
        sqs_provider: object | None = None,
        events_provider: object | None = None,
        compute_providers: dict[str, ICompute] | None = None,
    ) -> None:
        """Wire in downstream providers for config-based notification dispatch."""
        self._sns_provider = sns_provider
        self._sqs_provider = sqs_provider
        self._events_provider = events_provider
        self._compute_providers = compute_providers or {}

    def register(
        self,
        bucket: str,
        event_type: str,
        handler: Callable,
        prefix_filter: str = "",
        suffix_filter: str = "",
    ) -> None:
        """Register a handler for a specific bucket and event type.

        Args:
            bucket: The bucket name to listen on.
            event_type: Event type pattern, e.g. ``ObjectCreated:*``.
            handler: An async callable that receives the event record dict.
            prefix_filter: Only dispatch if the key starts with this prefix.
            suffix_filter: Only dispatch if the key ends with this suffix.
        """
        self._handlers.append(
            {
                "bucket": bucket,
                "event_type": event_type,
                "handler": handler,
                "prefix_filter": prefix_filter,
                "suffix_filter": suffix_filter,
            }
        )

    def dispatch(self, bucket: str, event_type: str, key: str) -> None:
        """Evaluate filters and dispatch matching events asynchronously.

        Builds an S3-style event record and dispatches to each matching
        handler via ``asyncio.create_task``. Also dispatches to configured
        SNS/SQS/EventBridge/Lambda targets from the bucket notification config.
        """
        record = _build_event_record(bucket, event_type, key)

        for entry in self._handlers:
            if not _matches(entry, bucket, event_type, key):
                continue
            asyncio.create_task(_safe_invoke(entry["handler"], record))

        if self._config_getter is not None:
            config_xml = self._config_getter(bucket)
            targets = _parse_notification_config(config_xml)
            for target in targets:
                if not _event_type_matches(target["event_type"], event_type):
                    continue
                prefix_filter = target.get("prefix_filter", "")
                suffix_filter = target.get("suffix_filter", "")
                if prefix_filter and not key.startswith(prefix_filter):
                    continue
                if suffix_filter and not key.endswith(suffix_filter):
                    continue
                asyncio.create_task(
                    _dispatch_config_target(
                        target=target,
                        record=record,
                        sns_provider=self._sns_provider,
                        sqs_provider=self._sqs_provider,
                        events_provider=self._events_provider,
                        compute_providers=self._compute_providers,
                    )
                )


def _matches(entry: dict, bucket: str, event_type: str, key: str) -> bool:
    """Check whether a handler entry matches the given event."""
    if entry["bucket"] != bucket:
        return False
    if not _event_type_matches(entry["event_type"], event_type):
        return False
    if entry["prefix_filter"] and not key.startswith(entry["prefix_filter"]):
        return False
    if entry["suffix_filter"] and not key.endswith(entry["suffix_filter"]):
        return False
    return True


def _event_type_matches(pattern: str, actual: str) -> bool:
    """Match event type patterns like ``ObjectCreated:*`` against ``ObjectCreated:Put``."""
    if pattern == actual:
        return True
    # Wildcard: ``ObjectCreated:*`` matches ``ObjectCreated:Put``
    if pattern.endswith(":*"):
        category = pattern[: -len(":*")]
        return actual.startswith(category + ":")
    return False


def _build_event_record(bucket: str, event_type: str, key: str) -> dict:
    """Build an S3-compatible event record dict."""
    now = datetime.now(UTC).isoformat()
    return {
        "eventVersion": "2.1",
        "eventSource": "ldk:s3",
        "eventTime": now,
        "eventName": f"s3:{event_type}",
        "s3": {
            "bucket": {"name": bucket},
            "object": {"key": key},
        },
    }


async def _safe_invoke(handler: Callable, record: dict) -> None:
    """Invoke a handler, catching and logging any exceptions."""
    try:
        result = handler(record)
        if asyncio.iscoroutine(result):
            await result
    except Exception:
        logger.exception("Error in S3 notification handler")


def _parse_notification_config(config_xml: str) -> list[dict]:
    """Parse an S3 notification configuration XML string into target dicts.

    Returns a list of target dicts with keys: ``target_type``, ``arn``,
    ``event_type``, ``prefix_filter``, ``suffix_filter``.
    """
    try:
        root = ET.fromstring(config_xml)  # noqa: S314
    except ET.ParseError:
        logger.warning("Failed to parse S3 notification configuration XML")
        return []

    ns = ""
    if root.tag.startswith("{"):
        ns = root.tag.split("}")[0] + "}"

    targets: list[dict] = []
    targets.extend(_parse_queue_configs(root, ns))
    targets.extend(_parse_topic_configs(root, ns))
    targets.extend(_parse_lambda_configs(root, ns))
    targets.extend(_parse_eventbridge_configs(root, ns))
    return targets


def _parse_queue_configs(root: ET.Element, ns: str) -> list[dict]:
    """Extract SQS queue notification targets from an XML root element."""
    targets: list[dict] = []
    for queue_cfg in root.findall(f"{ns}QueueConfiguration"):
        arn_elem = queue_cfg.find(f"{ns}Queue")
        arn = arn_elem.text if arn_elem is not None and arn_elem.text else ""
        prefix_filter, suffix_filter = _parse_filter(queue_cfg, ns)
        for event_elem in queue_cfg.findall(f"{ns}Event"):
            targets.append(
                {
                    "target_type": "sqs",
                    "arn": arn,
                    "event_type": _s3_event_to_internal(event_elem.text or ""),
                    "prefix_filter": prefix_filter,
                    "suffix_filter": suffix_filter,
                }
            )
    return targets


def _parse_topic_configs(root: ET.Element, ns: str) -> list[dict]:
    """Extract SNS topic notification targets from an XML root element."""
    targets: list[dict] = []
    for topic_cfg in root.findall(f"{ns}TopicConfiguration"):
        arn_elem = topic_cfg.find(f"{ns}Topic")
        arn = arn_elem.text if arn_elem is not None and arn_elem.text else ""
        prefix_filter, suffix_filter = _parse_filter(topic_cfg, ns)
        for event_elem in topic_cfg.findall(f"{ns}Event"):
            targets.append(
                {
                    "target_type": "sns",
                    "arn": arn,
                    "event_type": _s3_event_to_internal(event_elem.text or ""),
                    "prefix_filter": prefix_filter,
                    "suffix_filter": suffix_filter,
                }
            )
    return targets


def _parse_lambda_configs(root: ET.Element, ns: str) -> list[dict]:
    """Extract Lambda function notification targets from an XML root element."""
    targets: list[dict] = []
    for lambda_cfg in root.findall(f"{ns}LambdaFunctionConfiguration"):
        arn_elem = lambda_cfg.find(f"{ns}CloudFunction")
        arn = arn_elem.text if arn_elem is not None and arn_elem.text else ""
        prefix_filter, suffix_filter = _parse_filter(lambda_cfg, ns)
        for event_elem in lambda_cfg.findall(f"{ns}Event"):
            targets.append(
                {
                    "target_type": "lambda",
                    "arn": arn,
                    "event_type": _s3_event_to_internal(event_elem.text or ""),
                    "prefix_filter": prefix_filter,
                    "suffix_filter": suffix_filter,
                }
            )
    return targets


def _parse_eventbridge_configs(root: ET.Element, ns: str) -> list[dict]:
    """Extract EventBridge notification targets from an XML root element."""
    targets: list[dict] = []
    for eb_cfg in root.findall(f"{ns}EventBridgeConfiguration"):
        prefix_filter, suffix_filter = _parse_filter(eb_cfg, ns)
        for event_elem in eb_cfg.findall(f"{ns}Event"):
            targets.append(
                {
                    "target_type": "eventbridge",
                    "arn": "",
                    "event_type": _s3_event_to_internal(event_elem.text or ""),
                    "prefix_filter": prefix_filter,
                    "suffix_filter": suffix_filter,
                }
            )
    return targets


def _parse_filter(config_elem: ET.Element, ns: str) -> tuple[str, str]:
    """Extract prefix and suffix filters from a notification configuration element."""
    prefix_filter = ""
    suffix_filter = ""
    filter_elem = config_elem.find(f"{ns}Filter")
    if filter_elem is None:
        return prefix_filter, suffix_filter
    s3_key = filter_elem.find(f"{ns}S3Key")
    if s3_key is None:
        return prefix_filter, suffix_filter
    for rule in s3_key.findall(f"{ns}FilterRule"):
        name_elem = rule.find(f"{ns}Name")
        value_elem = rule.find(f"{ns}Value")
        if name_elem is None or value_elem is None:
            continue
        name = (name_elem.text or "").lower()
        value = value_elem.text or ""
        if name == "prefix":
            prefix_filter = value
        elif name == "suffix":
            suffix_filter = value
    return prefix_filter, suffix_filter


def _s3_event_to_internal(s3_event: str) -> str:
    """Convert an S3 event name like ``s3:ObjectCreated:*`` to ``ObjectCreated:*``."""
    if s3_event.startswith("s3:"):
        return s3_event[len("s3:") :]
    return s3_event


async def _dispatch_config_target(
    target: dict,
    record: dict,
    sns_provider: object | None,
    sqs_provider: object | None,
    events_provider: object | None,
    compute_providers: dict[str, ICompute],
) -> None:
    """Dispatch a single S3 event to a configured notification target."""
    target_type = target["target_type"]
    arn = target["arn"]
    event_json = json.dumps({"Records": [record]})

    try:
        if target_type == "sns":
            await _dispatch_to_sns(sns_provider, arn, event_json)
        elif target_type == "sqs":
            await _dispatch_to_sqs(sqs_provider, arn, event_json)
        elif target_type == "eventbridge":
            await _dispatch_to_eventbridge(events_provider, record)
        elif target_type == "lambda":
            await _dispatch_to_lambda(compute_providers, arn, record)
    except Exception:
        logger.exception(
            "Error dispatching S3 notification to %s target %s",
            target_type,
            arn,
        )


async def _dispatch_to_sns(sns_provider: object | None, topic_arn: str, event_json: str) -> None:
    """Publish an S3 event to an SNS topic."""
    if sns_provider is None:
        logger.warning("SNS provider not configured for S3 notification dispatch")
        return
    topic_name = topic_arn.rsplit(":", 1)[-1] if ":" in topic_arn else topic_arn
    await sns_provider.publish(topic_name=topic_name, message=event_json)  # type: ignore[union-attr]


async def _dispatch_to_sqs(sqs_provider: object | None, queue_arn: str, event_json: str) -> None:
    """Send an S3 event to an SQS queue."""
    if sqs_provider is None:
        logger.warning("SQS provider not configured for S3 notification dispatch")
        return
    queue_name = queue_arn.rsplit(":", 1)[-1] if ":" in queue_arn else queue_arn
    await sqs_provider.send_message(queue_name=queue_name, message_body=event_json)  # type: ignore[union-attr]


async def _dispatch_to_eventbridge(events_provider: object | None, record: dict) -> None:
    """Put an S3 event onto the default EventBridge bus."""
    if events_provider is None:
        logger.warning("EventBridge provider not configured for S3 notification dispatch")
        return
    bucket_name = record.get("s3", {}).get("bucket", {}).get("name", "")
    object_key = record.get("s3", {}).get("object", {}).get("key", "")
    entry = {
        "Source": "aws.s3",
        "DetailType": "Object Change",
        "Detail": json.dumps(
            {
                "eventName": record.get("eventName", ""),
                "bucket": {"name": bucket_name},
                "object": {"key": object_key},
            }
        ),
        "EventBusName": "default",
    }
    await events_provider.put_events([entry])  # type: ignore[union-attr]


async def _dispatch_to_lambda(
    compute_providers: dict[str, ICompute], function_arn: str, record: dict
) -> None:
    """Invoke a Lambda function with an S3 event."""
    function_name = function_arn.rsplit(":", 1)[-1] if ":" in function_arn else function_arn
    compute = compute_providers.get(function_name)
    if compute is None:
        logger.error("No compute provider found for Lambda function: %s", function_name)
        return
    event = {"Records": [record]}
    context = LambdaContext(
        function_name=function_name,
        memory_limit_in_mb=128,
        timeout_seconds=30,
        aws_request_id=str(uuid.uuid4()),
        invoked_function_arn=function_arn,
    )
    await compute.invoke(event, context)
