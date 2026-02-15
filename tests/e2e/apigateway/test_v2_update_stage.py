import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestV2UpdateStage:
    def test_v2_update_stage(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "v2-create-api",
                "--name",
                "e2e-v2-update-stage",
                "--port",
                str(e2e_port),
            ]
        )
        api_id = created["apiId"]
        lws_invoke(
            [
                "apigateway",
                "v2-create-stage",
                "--api-id",
                api_id,
                "--stage-name",
                "e2e-prod",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "v2-update-stage",
                "--api-id",
                api_id,
                "--stage-name",
                "e2e-prod",
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
