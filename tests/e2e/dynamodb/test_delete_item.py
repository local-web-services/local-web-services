from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteItem:
    def test_delete_item(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        table_name = "e2e-del-item"
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
                '{"pk": {"S": "k1"}}',
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "dynamodb",
                "delete-item",
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
        verify = assert_invoke(
            ["dynamodb", "scan", "--table-name", table_name, "--port", str(e2e_port)]
        )
        actual_count = verify["Count"]
        assert actual_count == 0
