import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestTestInvokeMethod:
    def test_test_invoke_method(self, e2e_port, lws_invoke):
        # Arrange — nothing needed

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "test-invoke-method",
                "--resource",
                "/health",
                "--http-method",
                "GET",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        assert "status" in json.loads(result.output)
