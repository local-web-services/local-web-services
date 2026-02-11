import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateTable:
    def test_create_table(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        table_name = "e2e-create-tbl"

        # Act
        result = runner.invoke(
            app,
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
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        assert json.loads(result.output)["TableDescription"]["TableName"] == table_name
        verify = assert_invoke(
            ["dynamodb", "describe-table", "--table-name", table_name, "--port", str(e2e_port)]
        )
        actual_name = verify["Table"]["TableName"]
        assert actual_name == table_name
