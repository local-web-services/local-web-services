from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteStage:
    def test_delete_stage(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "create-rest-api",
                "--name",
                "e2e-delete-stage",
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
                "to-delete",
                "--deployment-id",
                deployment_id,
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "delete-stage",
                "--rest-api-id",
                rest_api_id,
                "--stage-name",
                "to-delete",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
