"""Tests for DynamoDB CLI table management commands."""

from __future__ import annotations

import json
from unittest.mock import AsyncMock, patch

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()

_TARGET_PREFIX = "DynamoDB_20120810"


def _mock_client_response(return_value: dict) -> AsyncMock:
    mock = AsyncMock()
    mock.json_target_request = AsyncMock(return_value=return_value)
    return mock


class TestCreateTable:
    def test_create_table_calls_correct_endpoint(self) -> None:
        mock = _mock_client_response({"TableDescription": {"TableName": "MyTable"}})
        with patch("lws.cli.services.dynamodb._client", return_value=mock):
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
                ],
            )

        assert result.exit_code == 0
        mock.json_target_request.assert_awaited_once()
        call_args = mock.json_target_request.call_args
        assert call_args[0][0] == "dynamodb"
        assert call_args[0][1] == f"{_TARGET_PREFIX}.CreateTable"
        body = call_args[0][2]
        assert body["TableName"] == "MyTable"
        assert body["KeySchema"] == [{"AttributeName": "pk", "KeyType": "HASH"}]
        assert body["AttributeDefinitions"] == [{"AttributeName": "pk", "AttributeType": "S"}]

    def test_create_table_with_gsi(self) -> None:
        mock = _mock_client_response({"TableDescription": {"TableName": "MyTable"}})
        gsis = [
            {
                "IndexName": "gsi1",
                "KeySchema": [{"AttributeName": "gsi1pk", "KeyType": "HASH"}],
                "Projection": {"ProjectionType": "ALL"},
            }
        ]
        with patch("lws.cli.services.dynamodb._client", return_value=mock):
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

        assert result.exit_code == 0
        body = mock.json_target_request.call_args[0][2]
        assert "GlobalSecondaryIndexes" in body
