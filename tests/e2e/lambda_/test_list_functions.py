"""E2E test for Lambda list-functions CLI command."""

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListFunctions:
    def test_list_functions(self, e2e_port):
        # Arrange — no setup needed

        # Act
        result = runner.invoke(
            app,
            ["lambda", "list-functions", "--port", str(e2e_port)],
        )

        # Assert
        assert result.exit_code == 0, result.output
