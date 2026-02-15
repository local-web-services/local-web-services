"""E2E test for DynamoDB batch-get-item CLI command."""

import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestBatchGetItem:
    def test_batch_get_item(self, e2e_port, lws_invoke):
        # Arrange
        table_name = "e2e-batch-get"
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
                json.dumps({"pk": {"S": "bg1"}, "data": {"S": "hello"}}),
                "--port",
                str(e2e_port),
            ]
        )
        request_items = json.dumps({table_name: {"Keys": [{"pk": {"S": "bg1"}}]}})

        # Act
        result = runner.invoke(
            app,
            [
                "dynamodb",
                "batch-get-item",
                "--request-items",
                request_items,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
