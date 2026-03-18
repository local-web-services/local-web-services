"""Discover AWS resources from a CDK cloud assembly (cdk.out/)."""

from __future__ import annotations

from pathlib import Path
from typing import Any


def discover(project_dir: Path) -> dict[str, Any]:
    """Parse the CDK cloud assembly and return a resource spec dict.

    Reads ``{project_dir}/cdk.out/`` (runs ``cdk synth`` first if absent is
    acceptable — callers should run ``npx cdk synth`` beforehand).

    Returns a dict compatible with :class:`~lws_testing.LwsSession` kwargs:
    ``tables``, ``queues``, ``buckets``, ``topics``, ``state_machines``,
    ``secrets``, ``parameters``.
    """
    from lws.parser.assembly import parse_assembly

    cdk_out = project_dir / "cdk.out"
    if not cdk_out.exists():
        raise FileNotFoundError(
            f"CDK cloud assembly not found at {cdk_out}. "
            "Run 'npx cdk synth' in your CDK project first."
        )

    model = parse_assembly(cdk_out)

    tables = _extract_tables(model.tables)
    queues = _extract_queues(model.queues)
    buckets = [b.name for b in model.buckets]
    topics = [{"name": t.name, "arn": t.topic_arn} for t in model.topics]
    state_machines = _extract_state_machines(model.state_machines)
    parameters = _extract_parameters(model.ssm_parameters)
    secrets = _extract_secrets(model.secrets)

    return {
        "buckets": buckets,
        "parameters": parameters,
        "queues": queues,
        "secrets": secrets,
        "state_machines": state_machines,
        "tables": tables,
        "topics": topics,
    }


def _extract_tables(dynamo_tables: list[Any]) -> list[dict[str, Any]]:
    """Convert DynamoTable models to table spec dicts."""
    result = []
    for table in dynamo_tables:
        spec: dict[str, Any] = {"name": table.name}
        for key in table.key_schema:
            key_type = key.get("KeyType", "")
            attr_name = key.get("AttributeName", "")
            if key_type == "HASH":
                spec["partition_key"] = attr_name
            elif key_type == "RANGE":
                spec["sort_key"] = attr_name
        if "partition_key" not in spec:
            # Skip tables without a parseable partition key
            continue
        result.append(spec)
    return result


def _extract_queues(sqs_queues: list[Any]) -> list[dict[str, Any]]:
    """Convert SqsQueue models to queue spec dicts."""
    return [
        {
            "name": q.name,
            "is_fifo": q.is_fifo,
            "visibility_timeout": q.visibility_timeout,
            "content_based_dedup": q.content_based_dedup,
        }
        for q in sqs_queues
    ]


def _extract_state_machines(state_machines: list[Any]) -> list[dict[str, Any]]:
    """Convert StateMachine models to state machine spec dicts."""
    return [
        {
            "name": sm.name,
            "definition": sm.definition,
            "role_arn": sm.role_arn,
        }
        for sm in state_machines
    ]


def _extract_parameters(ssm_parameters: list[Any]) -> list[dict[str, Any]]:
    """Convert SsmParameter models to parameter spec dicts."""
    return [
        {
            "name": p.name,
            "value": p.value,
            "type": p.type,
            "description": p.description,
        }
        for p in ssm_parameters
    ]


def _extract_secrets(secrets: list[Any]) -> list[dict[str, Any]]:
    """Convert SmSecret models to secret spec dicts."""
    return [
        {
            "name": s.name,
            "description": s.description,
            "secret_string": s.secret_string or "",
        }
        for s in secrets
    ]
