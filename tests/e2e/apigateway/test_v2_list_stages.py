import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestV2ListStages:
    def test_v2_list_stages(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "v2-create-api",
                "--name",
                "e2e-v2-list-stages",
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
                "test",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "v2-list-stages",
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
