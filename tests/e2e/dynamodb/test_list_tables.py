import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListTables:
    def test_list_tables(self, e2e_port, lws_invoke):
        # Arrange
        table_name = "e2e-list-tbl"
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
                "list-tables",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        actual_tables = json.loads(result.output)["TableNames"]
        assert table_name in actual_tables
