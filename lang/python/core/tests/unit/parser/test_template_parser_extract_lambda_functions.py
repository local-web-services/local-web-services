"""Tests for ldk.parser.template_parser."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from lws.parser.template_parser import (
    CfnResource,
    extract_lambda_functions,
)


@pytest.fixture()
def tmp_template(tmp_path: Path):
    """Write a CloudFormation template dict and return the path."""

    def _write(template: dict) -> Path:
        p = tmp_path / "template.json"
        p.write_text(json.dumps(template), encoding="utf-8")
        return p

    return _write


# ---------------------------------------------------------------------------
# parse_template
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# extract_lambda_functions
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# extract_dynamo_tables
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# extract_api_routes
# ---------------------------------------------------------------------------


class TestExtractLambdaFunctions:
    def test_basic_lambda(self):
        # Arrange
        expected_handler = "app.handler"
        expected_runtime = "nodejs18.x"
        expected_timeout = 60
        expected_memory_size = 256
        expected_environment = {"TABLE": "my-table"}
        resources = [
            CfnResource(
                logical_id="Fn1",
                resource_type="AWS::Lambda::Function",
                properties={
                    "Handler": expected_handler,
                    "Runtime": expected_runtime,
                    "Code": {"S3Bucket": "bucket", "S3Key": "abc123.zip"},
                    "Timeout": expected_timeout,
                    "MemorySize": expected_memory_size,
                    "Environment": {"Variables": expected_environment},
                },
            ),
        ]

        # Act
        result = extract_lambda_functions(resources)

        # Assert
        assert len(result) == 1, f"Expected {1!r} but got {len(result)!r}"
        actual_func = result[0]
        assert actual_func.handler == expected_handler, f"Expected {expected_handler!r} but got {actual_func.handler!r}"
        assert actual_func.runtime == expected_runtime, f"Expected {expected_runtime!r} but got {actual_func.runtime!r}"
        assert actual_func.timeout == expected_timeout, f"Expected {expected_timeout!r} but got {actual_func.timeout!r}"
        assert actual_func.memory_size == expected_memory_size, f"Expected {expected_memory_size!r} but got {actual_func.memory_size!r}"
        assert actual_func.environment == expected_environment, f"Expected {expected_environment!r} but got {actual_func.environment!r}"

    def test_lambda_without_environment(self):
        # Arrange
        expected_environment = {}
        resources = [
            CfnResource(
                logical_id="Fn2",
                resource_type="AWS::Lambda::Function",
                properties={"Handler": "h", "Runtime": "python3.11"},
            ),
        ]

        # Act
        result = extract_lambda_functions(resources)

        # Assert
        actual_environment = result[0].environment
        assert actual_environment == expected_environment, f"Expected {expected_environment!r} but got {actual_environment!r}"

    def test_skips_non_lambda(self):
        # Arrange
        resources = [
            CfnResource("T", "AWS::DynamoDB::Table", {}),
        ]

        # Act / Assert
        assert extract_lambda_functions(resources) == [], f"Expected {[]!r} but got {extract_lambda_functions(resources)!r}"
