import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestGetDeployment:
    def test_get_deployment(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "create-rest-api",
                "--name",
                "e2e-get-deployment",
                "--port",
                str(e2e_port),
            ]
        )
        rest_api_id = created["id"]
        deployment = lws_invoke(
            [
                "apigateway",
                "create-deployment",
                "--rest-api-id",
                rest_api_id,
                "--port",
                str(e2e_port),
            ]
        )
        deployment_id = deployment["id"]

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "get-deployment",
                "--rest-api-id",
                rest_api_id,
                "--deployment-id",
                deployment_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        expected_id = deployment_id
        actual_id = body["id"]
        assert actual_id == expected_id
