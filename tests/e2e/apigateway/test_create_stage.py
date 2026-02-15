import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateStage:
    def test_create_stage(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "create-rest-api",
                "--name",
                "e2e-create-stage",
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
                "create-stage",
                "--rest-api-id",
                rest_api_id,
                "--stage-name",
                "e2e-dev",
                "--deployment-id",
                deployment_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        expected_stage_name = "e2e-dev"
        actual_stage_name = body["stageName"]
        assert actual_stage_name == expected_stage_name
