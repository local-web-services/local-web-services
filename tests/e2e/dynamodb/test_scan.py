import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestScan:
    def test_scan(self, e2e_port, lws_invoke):
        # Arrange
        table_name = "e2e-scan"
        expected_pks = ["s1", "s2"]
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
                '{"pk": {"S": "s1"}, "data": {"S": "a"}}',
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
                '{"pk": {"S": "s2"}, "data": {"S": "b"}}',
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "dynamodb",
                "scan",
                "--table-name",
                table_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        data = json.loads(result.output)
        assert data["Count"] >= 2
        actual_pks = [item["pk"]["S"] for item in data["Items"]]
        for pk in expected_pks:
            assert pk in actual_pks
