"""Tests for ldk.parser.template_parser."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from lws.parser.template_parser import (
    parse_template,
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


class TestParseTemplate:
    def test_extracts_resources(self, tmp_template):
        # Arrange
        expected_count = 2
        expected_first_id = "MyFunc"
        expected_first_type = "AWS::Lambda::Function"
        expected_second_id = "MyTable"
        tpl = {
            "AWSTemplateFormatVersion": "2010-09-09",
            "Resources": {
                expected_first_id: {
                    "Type": expected_first_type,
                    "Properties": {"Handler": "index.handler", "Runtime": "python3.11"},
                },
                expected_second_id: {
                    "Type": "AWS::DynamoDB::Table",
                    "Properties": {"TableName": "widgets"},
                },
            },
        }

        # Act
        resources = parse_template(tmp_template(tpl))

        # Assert
        assert len(resources) == expected_count
        assert resources[0].logical_id == expected_first_id
        assert resources[0].resource_type == expected_first_type
        assert resources[1].logical_id == expected_second_id

    def test_empty_resources(self, tmp_template):
        tpl = {"Resources": {}}
        assert parse_template(tmp_template(tpl)) == []

    def test_missing_resources_key(self, tmp_template):
        tpl = {"AWSTemplateFormatVersion": "2010-09-09"}
        assert parse_template(tmp_template(tpl)) == []
