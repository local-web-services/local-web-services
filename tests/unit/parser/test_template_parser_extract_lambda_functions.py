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
        assert len(result) == 1
        actual_func = result[0]
        assert actual_func.handler == expected_handler
        assert actual_func.runtime == expected_runtime
        assert actual_func.timeout == expected_timeout
        assert actual_func.memory_size == expected_memory_size
        assert actual_func.environment == expected_environment

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
        assert actual_environment == expected_environment

    def test_skips_non_lambda(self):
        # Arrange
        resources = [
            CfnResource("T", "AWS::DynamoDB::Table", {}),
        ]

        # Act / Assert
        assert extract_lambda_functions(resources) == []
