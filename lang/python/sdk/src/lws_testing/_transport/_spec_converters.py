"""Helpers that convert raw spec dicts into typed provider config objects."""

from __future__ import annotations

from typing import Any


def make_table_config(spec: dict[str, Any]) -> Any:
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


def make_queue_config(spec: str | dict[str, Any]) -> Any:
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


def make_topic_config(spec: str | dict[str, Any]) -> Any:
    """Convert a topic spec (str or dict) to a TopicConfig."""
    from lws.providers.sns.provider import TopicConfig

    if isinstance(spec, str):
        name = spec
        arn = f"arn:aws:sns:us-east-1:000000000000:{name}"
    else:
        name = spec["name"]
        arn = spec.get("arn", f"arn:aws:sns:us-east-1:000000000000:{name}")
    return TopicConfig(topic_name=name, topic_arn=arn)


def make_state_machine_config(spec: dict[str, Any]) -> Any:
    """Convert a state machine spec dict to a StateMachineConfig."""
    from lws.providers.stepfunctions.provider import StateMachineConfig

    return StateMachineConfig(
        name=spec["name"],
        definition=spec.get("definition", "{}"),
        role_arn=spec.get("role_arn", ""),
    )


def make_initial_parameter(spec: str | dict[str, Any]) -> dict[str, Any]:
    """Convert a parameter spec to the dict format expected by create_ssm_app."""
    if isinstance(spec, str):
        return {"name": spec, "value": "", "type": "String"}
    return spec


def make_initial_secret(spec: str | dict[str, Any]) -> dict[str, Any]:
    """Convert a secret spec to the dict format expected by create_secretsmanager_app."""
    if isinstance(spec, str):
        return {"name": spec, "secret_string": ""}
    return spec


def convert_spec(spec: dict[str, Any]) -> dict[str, list[Any]]:
    """Convert raw spec dict to typed provider config lists."""
    return {
        "tables": [make_table_config(t) for t in spec.get("tables", [])],
        "queues": [make_queue_config(q) for q in spec.get("queues", [])],
        "buckets": [b if isinstance(b, str) else b["name"] for b in spec.get("buckets", [])],
        "topics": [make_topic_config(t) for t in spec.get("topics", [])],
        "state_machines": [make_state_machine_config(sm) for sm in spec.get("state_machines", [])],
        "parameters": [make_initial_parameter(p) for p in spec.get("parameters", [])],
        "secrets": [make_initial_secret(s) for s in spec.get("secrets", [])],
    }
