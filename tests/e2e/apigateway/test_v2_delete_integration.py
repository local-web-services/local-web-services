from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestV2DeleteIntegration:
    def test_v2_delete_integration(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "v2-create-api",
                "--name",
                "e2e-v2-del-int",
                "--port",
                str(e2e_port),
            ]
        )
        api_id = created["apiId"]
        integration = lws_invoke(
            [
                "apigateway",
                "v2-create-integration",
                "--api-id",
                api_id,
                "--integration-type",
                "AWS_PROXY",
                "--port",
                str(e2e_port),
            ]
        )
        integration_id = integration["integrationId"]

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "v2-delete-integration",
                "--api-id",
                api_id,
                "--integration-id",
                integration_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
