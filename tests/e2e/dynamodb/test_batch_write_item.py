"""E2E test for DynamoDB batch-write-item CLI command."""

import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestBatchWriteItem:
    def test_batch_write_item(self, e2e_port, lws_invoke):
        # Arrange
        table_name = "e2e-batch-write"
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
        request_items = json.dumps(
            {
                table_name: [
                    {"PutRequest": {"Item": {"pk": {"S": "bw1"}, "data": {"S": "val1"}}}},
                    {"PutRequest": {"Item": {"pk": {"S": "bw2"}, "data": {"S": "val2"}}}},
                ]
            }
        )

        # Act
        result = runner.invoke(
            app,
            [
                "dynamodb",
                "batch-write-item",
                "--request-items",
                request_items,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
