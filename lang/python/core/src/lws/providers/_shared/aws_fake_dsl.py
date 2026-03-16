"""DSL file loader for AWS operation fakes.

Reads ``.lws/fakes/<name>/config.yaml`` and operation YAML files,
expanding helpers into full responses at load time.
"""

from __future__ import annotations

from pathlib import Path
from typing import Any

import yaml

from lws.providers._shared.aws_fake_helpers import expand_helpers
from lws.providers._shared.aws_operation_fake import (
    AwsFakeConfig,
    AwsFakeRule,
    parse_fake_response,
)


def load_aws_fake(fake_dir: Path) -> AwsFakeConfig | None:
    """Load an AWS fake config from *fake_dir*.

    Returns ``None`` if ``config.yaml`` does not contain a ``service:`` field
    (meaning it is a generic fake server, not an AWS fake).
    """
    config_path = fake_dir / "config.yaml"
    if not config_path.exists():
        return None
    raw = yaml.safe_load(config_path.read_text()) or {}
    service = raw.get("service")
    if not service:
        return None

    enabled = raw.get("enabled", True)
    rules: list[AwsFakeRule] = []

    ops_dir = fake_dir / "operations"
    if ops_dir.exists():
        for op_file in sorted(ops_dir.glob("*.yaml")):
            rules.extend(parse_operation_file(op_file, service, fake_dir))

    return AwsFakeConfig(service=service, enabled=enabled, rules=rules)


def parse_operation_file(
    path: Path, service: str, fake_dir: Path | None = None
) -> list[AwsFakeRule]:
    """Parse a single operation YAML file into a list of AwsFakeRule."""
    raw = yaml.safe_load(path.read_text()) or {}
    operations = raw.get("operations", [])
    rules: list[AwsFakeRule] = []
    for op_raw in operations:
        rules.append(_parse_single_operation(op_raw, service, fake_dir))
    return rules


def _parse_single_operation(
    op_raw: dict[str, Any], service: str, fake_dir: Path | None
) -> AwsFakeRule:
    """Parse one operation entry from the YAML."""
    operation = op_raw.get("operation", "")
    match_raw = op_raw.get("match", {})
    match_headers = dict(match_raw.get("headers", {}))

    helpers = op_raw.get("helpers")
    response_raw = op_raw.get("response", {})

    if helpers is not None and "body" in response_raw:
        raise ValueError(
            f"Operation '{operation}': cannot specify both 'helpers' and 'response.body'"
        )

    if helpers is not None:
        response = expand_helpers(service, operation, helpers, fake_dir=fake_dir)
        if "status" in response_raw:
            response.status = int(response_raw["status"])
        if "headers" in response_raw:
            response.headers.update(response_raw["headers"])
        if "delay_ms" in response_raw:
            response.delay_ms = int(response_raw["delay_ms"])
    else:
        response = parse_fake_response(response_raw)

    return AwsFakeRule(
        operation=operation,
        match_headers=match_headers,
        response=response,
    )


# ------------------------------------------------------------------
# YAML generators (used by CLI)
# ------------------------------------------------------------------


def generate_aws_fake_config_yaml(name: str, service: str) -> str:
    """Generate a config.yaml for a new AWS fake."""
    data = {"name": name, "service": service, "enabled": True}
    return yaml.dump(data, default_flow_style=False, sort_keys=False)


def generate_operation_yaml(
    operation: str,
    status: int = 200,
    body: Any = None,
    content_type: str | None = None,
    match_headers: dict[str, str] | None = None,
    helpers: dict[str, Any] | None = None,
) -> str:
    """Generate YAML for an operation rule."""
    op_entry: dict[str, Any] = {"operation": operation}
    if match_headers:
        op_entry["match"] = {"headers": match_headers}
    if helpers:
        op_entry["helpers"] = helpers
    else:
        resp: dict[str, Any] = {"status": status}
        if body is not None:
            resp["body"] = body
        if content_type:
            resp["content_type"] = content_type
        op_entry["response"] = resp

    data = {"operations": [op_entry]}
    return yaml.dump(data, default_flow_style=False, sort_keys=False)
