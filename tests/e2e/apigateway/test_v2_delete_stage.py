from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestV2DeleteStage:
    def test_v2_delete_stage(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "v2-create-api",
                "--name",
                "e2e-v2-delete-stage",
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
                "to-delete",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "v2-delete-stage",
                "--api-id",
                api_id,
                "--stage-name",
                "to-delete",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
