"""Validate mock definitions against an OpenAPI spec."""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Any

import yaml

from lws.providers.mockserver.models import MockServerConfig


@dataclass
class ValidationIssue:
    """A single validation issue found during spec comparison."""

    level: str  # "WARN" or "ERROR"
    message: str
    path: str = ""
    method: str = ""


def validate_against_spec(
    config: MockServerConfig,
    spec_path: Path,
) -> list[ValidationIssue]:
    """Compare mock definitions against an OpenAPI spec file.

    Returns a list of issues found.
    """
    raw = yaml.safe_load(spec_path.read_text())
    if raw is None:
        return [ValidationIssue(level="ERROR", message="Spec file is empty or invalid")]

    spec_paths = raw.get("paths", {})
    issues: list[ValidationIssue] = []

    _check_uncovered_paths(config, spec_paths, issues)
    _check_extra_routes(config, spec_paths, issues)
    _check_status_codes(config, spec_paths, issues)

    return issues


def _check_uncovered_paths(
    config: MockServerConfig,
    spec_paths: dict[str, Any],
    issues: list[ValidationIssue],
) -> None:
    """Check for spec paths not covered by mock routes."""
    mock_paths = {(r.path, r.method.upper()) for r in config.routes}
    for path, methods in spec_paths.items():
        for method in methods:
            if method.lower() in ("parameters", "summary", "description", "servers"):
                continue
            key = (path, method.upper())
            if key not in mock_paths:
                issues.append(
                    ValidationIssue(
                        level="WARN",
                        message=f"Spec path not covered by mock: {method.upper()} {path}",
                        path=path,
                        method=method.upper(),
                    )
                )


def _check_extra_routes(
    config: MockServerConfig,
    spec_paths: dict[str, Any],
    issues: list[ValidationIssue],
) -> None:
    """Check for mock routes not present in the spec."""
    spec_keys = set()
    for path, methods in spec_paths.items():
        for method in methods:
            if method.lower() not in ("parameters", "summary", "description", "servers"):
                spec_keys.add((path, method.upper()))

    for route in config.routes:
        key = (route.path, route.method.upper())
        if key not in spec_keys:
            issues.append(
                ValidationIssue(
                    level="WARN",
                    message=f"Mock route not in spec: {route.method} {route.path}",
                    path=route.path,
                    method=route.method,
                )
            )


def _check_status_codes(
    config: MockServerConfig,
    spec_paths: dict[str, Any],
    issues: list[ValidationIssue],
) -> None:
    """Check for mock status codes not present in the spec."""
    for route in config.routes:
        spec_methods = spec_paths.get(route.path, {})
        spec_op = spec_methods.get(route.method.lower(), {})
        spec_responses = spec_op.get("responses", {})
        spec_codes = {int(c) for c in spec_responses if c.isdigit()}

        for _criteria, response in route.responses:
            if spec_codes and response.status not in spec_codes:
                issues.append(
                    ValidationIssue(
                        level="WARN",
                        message=(
                            f"Status {response.status} not in spec for "
                            f"{route.method} {route.path}"
                        ),
                        path=route.path,
                        method=route.method,
                    )
                )
