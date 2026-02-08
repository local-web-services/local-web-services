"""Tests for ldk.parser.template_parser."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from ldk.parser.template_parser import (
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
        resources = [
            CfnResource(
                logical_id="Fn1",
                resource_type="AWS::Lambda::Function",
                properties={
                    "Handler": "app.handler",
                    "Runtime": "nodejs18.x",
                    "Code": {"S3Bucket": "bucket", "S3Key": "abc123.zip"},
                    "Timeout": 60,
                    "MemorySize": 256,
                    "Environment": {"Variables": {"TABLE": "my-table"}},
                },
            ),
        ]
        result = extract_lambda_functions(resources)
        assert len(result) == 1
        lp = result[0]
        assert lp.handler == "app.handler"
        assert lp.runtime == "nodejs18.x"
        assert lp.timeout == 60
        assert lp.memory_size == 256
        assert lp.environment == {"TABLE": "my-table"}

    def test_lambda_without_environment(self):
        resources = [
            CfnResource(
                logical_id="Fn2",
                resource_type="AWS::Lambda::Function",
                properties={"Handler": "h", "Runtime": "python3.11"},
            ),
        ]
        result = extract_lambda_functions(resources)
        assert result[0].environment == {}

    def test_skips_non_lambda(self):
        resources = [
            CfnResource("T", "AWS::DynamoDB::Table", {}),
        ]
        assert extract_lambda_functions(resources) == []
