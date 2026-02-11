import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestGetItem:
    def test_get_item(self, e2e_port, lws_invoke):
        # Arrange
        table_name = "e2e-get-item"
        expected_value = "found"
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
                json.dumps({"pk": {"S": "k1"}, "val": {"S": expected_value}}),
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "dynamodb",
                "get-item",
                "--table-name",
                table_name,
                "--key",
                '{"pk": {"S": "k1"}}',
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        actual_value = json.loads(result.output)["Item"]["val"]["S"]
        assert actual_value == expected_value
