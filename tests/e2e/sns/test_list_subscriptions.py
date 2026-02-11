import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListSubscriptions:
    def test_list_subscriptions(self, e2e_port, lws_invoke):
        # Arrange — nothing needed

        # Act
        result = runner.invoke(
            app,
            [
                "sns",
                "list-subscriptions",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        assert "ListSubscriptionsResponse" in json.loads(result.output)
