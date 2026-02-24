"""Tests for DynamoDB CLI table management commands."""

from __future__ import annotations

import json
from unittest.fake import AsyncFake, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

_TARGET_PREFIX = "DynamoDB_20120810"


def _fake_client_response(return_value: dict) -> AsyncFake:
    fake = AsyncFake()
    fake.json_target_request = AsyncFake(return_value=return_value)
    return fake


class TestCreateTable:
    def test_create_table_calls_correct_endpoint(self) -> None:
        # Arrange
        expected_exit_code = 0
        expected_service = "dynamodb"
        expected_target = f"{_TARGET_PREFIX}.CreateTable"
        expected_table_name = "MyTable"
        expected_key_schema = [{"AttributeName": "pk", "KeyType": "HASH"}]
        expected_attribute_definitions = [{"AttributeName": "pk", "AttributeType": "S"}]
        fake = _fake_client_response({"TableDescription": {"TableName": expected_table_name}})

        # Act
        with patch("lws.cli.services.dynamodb._client", return_value=fake):
            result = runner.invoke(
                app,
                [
                    "dynamodb",
                    "create-table",
                    "--table-name",
                    expected_table_name,
                    "--key-schema",
                    json.dumps(expected_key_schema),
                    "--attribute-definitions",
                    json.dumps(expected_attribute_definitions),
                ],
            )

        # Assert
        assert result.exit_code == expected_exit_code
        fake.json_target_request.assert_awaited_once()
        call_args = fake.json_target_request.call_args
        actual_service = call_args[0][0]
        actual_target = call_args[0][1]
        actual_body = call_args[0][2]
        assert actual_service == expected_service
        assert actual_target == expected_target
        assert actual_body["TableName"] == expected_table_name
        assert actual_body["KeySchema"] == expected_key_schema
        assert actual_body["AttributeDefinitions"] == expected_attribute_definitions

    def test_create_table_with_gsi(self) -> None:
        # Arrange
        expected_exit_code = 0
        fake = _fake_client_response({"TableDescription": {"TableName": "MyTable"}})
        gsis = [
            {
                "IndexName": "gsi1",
                "KeySchema": [{"AttributeName": "gsi1pk", "KeyType": "HASH"}],
                "Projection": {"ProjectionType": "ALL"},
            }
        ]

        # Act
        with patch("lws.cli.services.dynamodb._client", return_value=fake):
            result = runner.invoke(
                app,
                [
                    "dynamodb",
                    "create-table",
                    "--table-name",
                    "MyTable",
                    "--key-schema",
                    json.dumps([{"AttributeName": "pk", "KeyType": "HASH"}]),
                    "--attribute-definitions",
                    json.dumps([{"AttributeName": "pk", "AttributeType": "S"}]),
                    "--global-secondary-indexes",
                    json.dumps(gsis),
                ],
            )

        # Assert
        assert result.exit_code == expected_exit_code
        actual_body = fake.json_target_request.call_args[0][2]
        assert "GlobalSecondaryIndexes" in actual_body
