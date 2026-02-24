"""Discover AWS resources from Terraform HCL (.tf) files."""

from __future__ import annotations

import re
from pathlib import Path
from typing import Any

# Matches:  resource "aws_dynamodb_table" "logical_name" {
_RESOURCE_HEADER = re.compile(
    r'resource\s+"(?P<type>[^"]+)"\s+"(?P<logical>[^"]+)"\s*\{',
)
# Matches a simple  key = "value"  assignment
_ATTR_STR = re.compile(r'^\s*(?P<key>\w+)\s*=\s*"(?P<value>[^"]*)"')
# Matches a simple  key = value  (unquoted booleans / numbers)
_ATTR_BARE = re.compile(r"^\s*(?P<key>\w+)\s*=\s*(?P<value>\S+)")
# Matches a heredoc opener:  key = <<MARKER
_ATTR_HEREDOC = re.compile(r"^\s*(?P<key>\w+)\s*=\s*<<(?P<marker>\w+)\s*$")

# Maps Terraform resource types to (collection_key, builder_function)
_DISPATCH: dict[str, tuple[str, Any]] = {
    "aws_dynamodb_table": ("tables", "_build_table"),
    "aws_sqs_queue": ("queues", "_build_queue"),
    "aws_s3_bucket": ("buckets", "_build_bucket"),
    "aws_sns_topic": ("topics", "_build_topic"),
    "aws_sfn_state_machine": ("state_machines", "_build_state_machine"),
    "aws_ssm_parameter": ("parameters", "_build_parameter"),
    "aws_secretsmanager_secret": ("secrets", "_build_secret"),
}


def discover(project_dir: Path) -> dict[str, Any]:
    """Parse ``.tf`` files in *project_dir* and return a resource spec dict.

    Returns a dict compatible with :class:`~lws_testing.LwsSession` kwargs:
    ``tables``, ``queues``, ``buckets``, ``topics``, ``state_machines``,
    ``secrets``, ``parameters``.
    """
    tf_files = list(project_dir.rglob("*.tf"))
    if not tf_files:
        raise FileNotFoundError(
            f"No .tf files found in {project_dir}. "
            "Make sure you point to the directory containing your Terraform files."
        )

    resources: list[tuple[str, str, dict[str, str]]] = []
    for tf_file in tf_files:
        resources.extend(_parse_tf_file(tf_file))

    return _classify_resources(resources)


def _classify_resources(
    resources: list[tuple[str, str, dict[str, str]]],
) -> dict[str, list[Any]]:
    """Route parsed resources into typed collections."""
    result: dict[str, list[Any]] = {
        "tables": [],
        "queues": [],
        "buckets": [],
        "topics": [],
        "state_machines": [],
        "parameters": [],
        "secrets": [],
    }
    handlers = _get_handlers()
    for resource_type, _logical, attrs in resources:
        if resource_type not in _DISPATCH:
            continue
        key, handler_name = _DISPATCH[resource_type]
        item = handlers[handler_name](attrs)
        if item is not None:
            result[key].append(item)
    return result


def _get_handlers() -> dict[str, Any]:
    """Return a map of handler name to callable."""
    return {
        "_build_table": _build_table,
        "_build_queue": _build_queue,
        "_build_bucket": _build_bucket,
        "_build_topic": _build_topic,
        "_build_state_machine": _build_state_machine,
        "_build_parameter": _build_parameter,
        "_build_secret": _build_secret,
    }


def _parse_tf_file(path: Path) -> list[tuple[str, str, dict[str, str]]]:
    """Parse a single .tf file and return list of (resource_type, logical_name, attrs)."""
    text = path.read_text(encoding="utf-8")
    results: list[tuple[str, str, dict[str, str]]] = []
    lines = text.splitlines()
    i = 0
    while i < len(lines):
        m = _RESOURCE_HEADER.search(lines[i])
        if m:
            resource_type = m.group("type")
            logical_name = m.group("logical")
            attrs, i = _collect_block(lines, i + 1)
            results.append((resource_type, logical_name, attrs))
        else:
            i += 1
    return results


def _try_heredoc(lines: list[str], i: int) -> tuple[str, str, int] | None:
    """If line *i* is a heredoc opener, return *(key, value, next_i)*, else *None*."""
    m = _ATTR_HEREDOC.match(lines[i])
    if not m:
        return None
    key = m.group("key")
    marker = m.group("marker")
    i += 1
    body: list[str] = []
    while i < len(lines) and lines[i].rstrip() != marker:
        body.append(lines[i])
        i += 1
    return key, "\n".join(body), i + 1  # i+1 advances past the closing marker


def _extract_attr(line: str) -> tuple[str, str] | None:
    """Return *(key, value)* if *line* is a simple attribute assignment, else *None*."""
    m = _ATTR_STR.match(line)
    if m:
        return m.group("key"), m.group("value")
    m2 = _ATTR_BARE.match(line)
    if m2:
        return m2.group("key"), m2.group("value")
    return None


def _collect_block(lines: list[str], start: int) -> tuple[dict[str, str], int]:
    """Collect top-level key=value pairs until the matching closing brace."""
    attrs: dict[str, str] = {}
    depth = 1
    i = start
    while i < len(lines) and depth > 0:
        line = lines[i]

        # Check for heredoc before adjusting depth so JSON braces inside
        # the heredoc body do not corrupt the brace counter.
        if depth == 1:
            result = _try_heredoc(lines, i)
            if result is not None:
                key, value, i = result
                attrs[key] = value
                continue

        depth += line.count("{") - line.count("}")
        if depth > 1:
            i += 1
            continue
        if depth == 0:
            break
        pair = _extract_attr(line)
        if pair is not None:
            attrs[pair[0]] = pair[1]
        i += 1
    return attrs, i + 1


def _build_table(attrs: dict[str, str]) -> dict[str, Any] | None:
    """Build a table spec dict from DynamoDB resource attributes."""
    name = attrs.get("name")
    hash_key = attrs.get("hash_key")
    if not name or not hash_key:
        return None
    spec: dict[str, Any] = {"name": name, "partition_key": hash_key}
    if "range_key" in attrs:
        spec["sort_key"] = attrs["range_key"]
    return spec


def _build_queue(attrs: dict[str, str]) -> dict[str, Any] | None:
    """Build a queue spec dict from SQS resource attributes."""
    name = attrs.get("name")
    if not name:
        return None
    is_fifo = attrs.get("fifo_queue", "false").lower() in ("true", "1")
    spec: dict[str, Any] = {"name": name, "is_fifo": is_fifo}
    if "visibility_timeout_seconds" in attrs:
        try:
            spec["visibility_timeout"] = int(attrs["visibility_timeout_seconds"])
        except ValueError:
            pass
    return spec


def _build_bucket(attrs: dict[str, str]) -> str | None:
    """Build a bucket name from S3 resource attributes."""
    return attrs.get("bucket") or attrs.get("name")


def _build_topic(attrs: dict[str, str]) -> dict[str, str] | None:
    """Build a topic spec dict from SNS resource attributes."""
    name = attrs.get("name")
    return {"name": name} if name else None


def _build_state_machine(attrs: dict[str, str]) -> dict[str, Any] | None:
    """Build a state machine spec dict from Step Functions resource attributes."""
    name = attrs.get("name")
    if not name:
        return None
    return {
        "name": name,
        "definition": attrs.get("definition", "{}"),
        "role_arn": attrs.get("role_arn", ""),
    }


def _build_parameter(attrs: dict[str, str]) -> dict[str, Any] | None:
    """Build a parameter spec dict from SSM resource attributes."""
    name = attrs.get("name")
    if not name:
        return None
    return {
        "name": name,
        "value": attrs.get("value", ""),
        "type": attrs.get("type", "String"),
        "description": attrs.get("description", ""),
    }


def _build_secret(attrs: dict[str, str]) -> dict[str, Any] | None:
    """Build a secret spec dict from Secrets Manager resource attributes."""
    name = attrs.get("name")
    if not name:
        return None
    return {
        "name": name,
        "description": attrs.get("description", ""),
        "secret_string": "",
    }
