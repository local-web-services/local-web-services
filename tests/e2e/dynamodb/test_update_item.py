"""E2E test for DynamoDB update-item CLI command."""

import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestUpdateItem:
    def test_update_item(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        table_name = "e2e-update-item"
        expected_data = "updated"
        lws_invoke(
            [
                "dynamodb",
                "create-table",
                "--table-name",
                table_name,
                "--key-schema",
                '[{"AttributeName":"pk","KeyType":"HASH"}]',
                "--attribute-definitions",
                '[{"AttributeName":"pk","AttributeType":"S"}]',
                "--port",
                str(e2e_port),
            ]
        )
        lws_invoke(
            [
                "dynamodb",
                "put-item",
                "--table-name",
                table_name,
                "--item",
                json.dumps({"pk": {"S": "k1"}, "data": {"S": "original"}}),
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "dynamodb",
                "update-item",
                "--table-name",
                table_name,
                "--key",
                '{"pk": {"S": "k1"}}',
                "--update-expression",
                "SET #d = :val",
                "--expression-attribute-values",
                json.dumps({":val": {"S": expected_data}}),
                "--expression-attribute-names",
                json.dumps({"#d": "data"}),
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            [
                "dynamodb",
                "get-item",
                "--table-name",
                table_name,
                "--key",
                '{"pk": {"S": "k1"}}',
                "--port",
                str(e2e_port),
            ]
        )
        actual_data = verify["Item"]["data"]["S"]
        assert actual_data == expected_data
