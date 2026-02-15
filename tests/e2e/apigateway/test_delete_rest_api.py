from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteRestApi:
    def test_delete_rest_api(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "create-rest-api",
                "--name",
                "e2e-delete-rest-api",
                "--port",
                str(e2e_port),
            ]
        )
        rest_api_id = created["id"]

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "delete-rest-api",
                "--rest-api-id",
                rest_api_id,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
