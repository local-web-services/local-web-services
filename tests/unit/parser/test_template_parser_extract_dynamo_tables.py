"""Tests for ldk.parser.template_parser."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from ldk.parser.template_parser import (
    CfnResource,
    extract_dynamo_tables,
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


class TestExtractDynamoTables:
    def test_basic_table(self):
        resources = [
            CfnResource(
                logical_id="Tbl",
                resource_type="AWS::DynamoDB::Table",
                properties={
                    "TableName": "orders",
                    "KeySchema": [
                        {"AttributeName": "pk", "KeyType": "HASH"},
                    ],
                    "AttributeDefinitions": [
                        {"AttributeName": "pk", "AttributeType": "S"},
                    ],
                    "GlobalSecondaryIndexes": [
                        {
                            "IndexName": "gsi1",
                            "KeySchema": [
                                {"AttributeName": "pk", "KeyType": "HASH"},
                            ],
                        }
                    ],
                },
            ),
        ]
        result = extract_dynamo_tables(resources)
        assert len(result) == 1
        tp = result[0]
        assert tp.table_name == "orders"
        assert len(tp.key_schema) == 1
        assert len(tp.gsi_definitions) == 1

    def test_table_without_gsi(self):
        resources = [
            CfnResource(
                logical_id="T",
                resource_type="AWS::DynamoDB::Table",
                properties={
                    "KeySchema": [{"AttributeName": "id", "KeyType": "HASH"}],
                    "AttributeDefinitions": [
                        {"AttributeName": "id", "AttributeType": "S"},
                    ],
                },
            ),
        ]
        result = extract_dynamo_tables(resources)
        assert result[0].gsi_definitions == []
