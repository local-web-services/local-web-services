import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestV2ListIntegrations:
    def test_v2_list_integrations(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "v2-create-api",
                "--name",
                "e2e-v2-list-ints",
                "--port",
                str(e2e_port),
            ]
        )
        api_id = created["apiId"]
        lws_invoke(
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

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "v2-list-integrations",
                "--api-id",
                api_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        assert "items" in body
        assert len(body["items"]) >= 1
