import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateDeployment:
    def test_create_deployment(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "create-rest-api",
                "--name",
                "e2e-create-deployment",
                "--port",
                str(e2e_port),
            ]
        )
        rest_api_id = created["id"]

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "create-deployment",
                "--rest-api-id",
                rest_api_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        assert "id" in body
