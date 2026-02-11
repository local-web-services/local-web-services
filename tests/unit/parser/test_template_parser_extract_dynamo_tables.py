"""Tests for ldk.parser.template_parser."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from lws.parser.template_parser import (
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
        # Arrange
        expected_table_name = "orders"
        expected_key_schema_count = 1
        expected_gsi_count = 1
        resources = [
            CfnResource(
                logical_id="Tbl",
                resource_type="AWS::DynamoDB::Table",
                properties={
                    "TableName": expected_table_name,
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

        # Act
        result = extract_dynamo_tables(resources)

        # Assert
        assert len(result) == 1
        actual_table = result[0]
        assert actual_table.table_name == expected_table_name
        assert len(actual_table.key_schema) == expected_key_schema_count
        assert len(actual_table.gsi_definitions) == expected_gsi_count

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
