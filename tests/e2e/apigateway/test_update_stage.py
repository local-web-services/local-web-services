import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestUpdateStage:
    def test_update_stage(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "create-rest-api",
                "--name",
                "e2e-update-stage",
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
        lws_invoke(
            [
                "apigateway",
                "create-stage",
                "--rest-api-id",
                rest_api_id,
                "--stage-name",
                "e2e-prod",
                "--deployment-id",
                deployment_id,
                "--port",
                str(e2e_port),
            ]
        )
        patch_ops = json.dumps([])

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "update-stage",
                "--rest-api-id",
                rest_api_id,
                "--stage-name",
                "e2e-prod",
                "--patch-operations",
                patch_ops,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        expected_stage_name = "e2e-prod"
        actual_stage_name = body["stageName"]
        assert actual_stage_name == expected_stage_name
