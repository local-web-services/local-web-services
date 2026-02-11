"""E2E test for ``lws lambda invoke``."""

import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestInvoke:
    def test_invoke_unknown_function_returns_error(self, e2e_port, lws_invoke):
        # Arrange
        function_name = "e2e-nonexistent-fn"

        # Act
        result = runner.invoke(
            app,
            [
                "lambda",
                "invoke",
                "--function-name",
                function_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        actual_body = json.loads(result.output)
        assert "Message" in actual_body
