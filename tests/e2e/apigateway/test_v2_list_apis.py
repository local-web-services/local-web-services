import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestV2ListApis:
    def test_v2_list_apis(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        lws_invoke(
            [
                "apigateway",
                "v2-create-api",
                "--name",
                "e2e-v2-list-apis",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "v2-list-apis",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        body = json.loads(result.output)
        assert "items" in body
