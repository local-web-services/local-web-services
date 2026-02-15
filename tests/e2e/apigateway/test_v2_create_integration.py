import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestV2CreateIntegration:
    def test_v2_create_integration(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "v2-create-api",
                "--name",
                "e2e-v2-create-int",
                "--port",
                str(e2e_port),
            ]
        )
        api_id = created["apiId"]

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "v2-create-integration",
                "--api-id",
                api_id,
                "--integration-type",
                "AWS_PROXY",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        assert "integrationId" in body
        expected_type = "AWS_PROXY"
        actual_type = body["integrationType"]
        assert actual_type == expected_type
