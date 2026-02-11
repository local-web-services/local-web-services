from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteTable:
    def test_delete_table(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        table_name = "e2e-del-tbl"
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
                "delete-table",
                "--table-name",
                table_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["dynamodb", "list-tables", "--port", str(e2e_port)])
        actual_tables = verify.get("TableNames", [])
        assert table_name not in actual_tables
