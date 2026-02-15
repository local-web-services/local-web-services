"""E2E test for Lambda list-event-source-mappings CLI command."""

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListEventSourceMappings:
    def test_list_event_source_mappings(self, e2e_port):
        # Arrange — no setup needed

        # Act
        result = runner.invoke(
            app,
            ["lambda", "list-event-source-mappings", "--port", str(e2e_port)],
        )

        # Assert
        assert result.exit_code == 0, result.output
