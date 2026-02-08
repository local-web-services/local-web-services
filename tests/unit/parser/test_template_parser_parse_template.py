"""Tests for ldk.parser.template_parser."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from ldk.parser.template_parser import (
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
        tpl = {
            "AWSTemplateFormatVersion": "2010-09-09",
            "Resources": {
                "MyFunc": {
                    "Type": "AWS::Lambda::Function",
                    "Properties": {"Handler": "index.handler", "Runtime": "python3.11"},
                },
                "MyTable": {
                    "Type": "AWS::DynamoDB::Table",
                    "Properties": {"TableName": "widgets"},
                },
            },
        }
        resources = parse_template(tmp_template(tpl))
        assert len(resources) == 2
        assert resources[0].logical_id == "MyFunc"
        assert resources[0].resource_type == "AWS::Lambda::Function"
        assert resources[1].logical_id == "MyTable"

    def test_empty_resources(self, tmp_template):
        tpl = {"Resources": {}}
        assert parse_template(tmp_template(tpl)) == []

    def test_missing_resources_key(self, tmp_template):
        tpl = {"AWSTemplateFormatVersion": "2010-09-09"}
        assert parse_template(tmp_template(tpl)) == []
