import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestQuery:
    def test_query(self, e2e_port, lws_invoke):
        # Arrange
        table_name = "e2e-query"
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
                json.dumps({"pk": {"S": "q1"}, "data": {"S": expected_value}}),
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "dynamodb",
                "query",
                "--table-name",
                table_name,
                "--key-condition-expression",
                "pk = :v",
                "--expression-attribute-values",
                '{ ":v": {"S": "q1"} }',
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        data = json.loads(result.output)
        assert data["Count"] >= 1
        actual_value = data["Items"][0]["data"]["S"]
        assert actual_value == expected_value
