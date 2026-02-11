import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDescribeTable:
    def test_describe_table(self, e2e_port, lws_invoke):
        # Arrange
        table_name = "e2e-desc-tbl"
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

        # Act
        result = runner.invoke(
            app,
            [
                "dynamodb",
                "describe-table",
                "--table-name",
                table_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        actual_name = json.loads(result.output)["Table"]["TableName"]
        assert actual_name == table_name
