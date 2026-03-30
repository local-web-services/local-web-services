"""Spec conversion helpers — convert raw dict specs to typed provider config objects."""

from __future__ import annotations

from typing import Any


def _make_table_config(spec: dict[str, Any]) -> Any:
    """Convert a table spec dict to a TableConfig."""
    from lws.interfaces.key_value_store import KeyAttribute, KeySchema, TableConfig

    pk = KeyAttribute(
        name=spec["partition_key"],
        type=spec.get("partition_key_type", "S"),
    )
    sk = None
    if "sort_key" in spec:
        sk = KeyAttribute(
            name=spec["sort_key"],
            type=spec.get("sort_key_type", "S"),
        )
    return TableConfig(
        table_name=spec["name"],
        key_schema=KeySchema(partition_key=pk, sort_key=sk),
    )


def _make_queue_config(spec: str | dict[str, Any]) -> Any:
    """Convert a queue spec (str or dict) to a QueueConfig."""
    from lws.providers.sqs.provider import QueueConfig

    if isinstance(spec, str):
        return QueueConfig(queue_name=spec)
    return QueueConfig(
        queue_name=spec["name"],
        visibility_timeout=spec.get("visibility_timeout", 30),
        is_fifo=spec.get("is_fifo", False),
        content_based_dedup=spec.get("content_based_dedup", False),
    )


def _make_topic_config(spec: str | dict[str, Any]) -> Any:
    """Convert a topic spec (str or dict) to a TopicConfig."""
    from lws.providers.sns.provider import TopicConfig

    if isinstance(spec, str):
        name = spec
        arn = f"arn:aws:sns:us-east-1:000000000000:{name}"
    else:
        name = spec["name"]
        arn = spec.get("arn", f"arn:aws:sns:us-east-1:000000000000:{name}")
    return TopicConfig(topic_name=name, topic_arn=arn)


def _make_state_machine_config(spec: dict[str, Any]) -> Any:
    """Convert a state machine spec dict to a StateMachineConfig."""
    from lws.providers.stepfunctions.provider import StateMachineConfig

    return StateMachineConfig(
        name=spec["name"],
        definition=spec.get("definition", "{}"),
        role_arn=spec.get("role_arn", ""),
    )


def _make_initial_parameter(spec: str | dict[str, Any]) -> dict[str, Any]:
    """Convert a parameter spec to the dict format expected by create_ssm_app."""
    if isinstance(spec, str):
        return {"name": spec, "value": "", "type": "String"}
    return spec


def _make_initial_secret(spec: str | dict[str, Any]) -> dict[str, Any]:
    """Convert a secret spec to the dict format expected by create_secretsmanager_app."""
    if isinstance(spec, str):
        return {"name": spec, "secret_string": ""}
    return spec
