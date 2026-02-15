"""E2E test for DynamoDB transact-get-items CLI command."""

import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestTransactGetItems:
    def test_transact_get_items(self, e2e_port, lws_invoke):
        # Arrange
        table_name = "e2e-transact-get"
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
                json.dumps({"pk": {"S": "tg1"}, "data": {"S": "value"}}),
                "--port",
                str(e2e_port),
            ]
        )
        transact_items = json.dumps(
            [
                {
                    "Get": {
                        "TableName": table_name,
                        "Key": {"pk": {"S": "tg1"}},
                    }
                }
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "dynamodb",
                "transact-get-items",
                "--transact-items",
                transact_items,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
