"""E2E test for DynamoDB transact-write-items CLI command."""

import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestTransactWriteItems:
    def test_condition_check_pass_allows_writes(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        table_name = "e2e-transact-cc-pass"
        expected_data = "written"
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
                json.dumps({"pk": {"S": "guard"}, "status": {"S": "ok"}}),
                "--port",
                str(e2e_port),
            ]
        )
        transact_items = json.dumps(
            [
                {
                    "ConditionCheck": {
                        "TableName": table_name,
                        "Key": {"pk": {"S": "guard"}},
                        "ConditionExpression": "attribute_exists(pk)",
                    }
                },
                {
                    "Put": {
                        "TableName": table_name,
                        "Item": {
                            "pk": {"S": "new-item"},
                            "data": {"S": expected_data},
                        },
                    }
                },
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "dynamodb",
                "transact-write-items",
                "--transact-items",
                transact_items,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            [
                "dynamodb",
                "get-item",
                "--table-name",
                table_name,
                "--key",
                '{"pk": {"S": "new-item"}}',
                "--port",
                str(e2e_port),
            ]
        )
        actual_data = verify["Item"]["data"]["S"]
        assert actual_data == expected_data

    def test_condition_check_fail_blocks_writes(self, e2e_port, lws_invoke, parse_output):
        # Arrange
        table_name = "e2e-transact-cc-fail"
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
        transact_items = json.dumps(
            [
                {
                    "ConditionCheck": {
                        "TableName": table_name,
                        "Key": {"pk": {"S": "nonexistent"}},
                        "ConditionExpression": "attribute_exists(pk)",
                    }
                },
                {
                    "Put": {
                        "TableName": table_name,
                        "Item": {
                            "pk": {"S": "blocked"},
                            "data": {"S": "nope"},
                        },
                    }
                },
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "dynamodb",
                "transact-write-items",
                "--transact-items",
                transact_items,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0
        body = parse_output(result.output)
        expected_error = "com.amazonaws.dynamodb.v20120810#TransactionCanceledException"
        actual_error = body["__type"]
        assert actual_error == expected_error
        get_result = runner.invoke(
            app,
            [
                "dynamodb",
                "get-item",
                "--table-name",
                table_name,
                "--key",
                '{"pk": {"S": "blocked"}}',
                "--port",
                str(e2e_port),
            ],
        )
        get_body = parse_output(get_result.output)
        assert "Item" not in get_body
