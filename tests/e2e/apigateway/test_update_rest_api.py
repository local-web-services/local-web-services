import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestUpdateRestApi:
    def test_update_rest_api(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "create-rest-api",
                "--name",
                "e2e-update-rest-api",
                "--port",
                str(e2e_port),
            ]
        )
        rest_api_id = created["id"]
        patch_ops = json.dumps([{"op": "replace", "path": "/name", "value": "e2e-updated"}])

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "update-rest-api",
                "--rest-api-id",
                rest_api_id,
                "--patch-operations",
                patch_ops,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        expected_name = "e2e-updated"
        actual_name = body["name"]
        assert actual_name == expected_name
