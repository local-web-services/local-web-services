from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteMethod:
    def test_delete_method(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        created = lws_invoke(
            [
                "apigateway",
                "create-rest-api",
                "--name",
                "e2e-delete-method",
                "--port",
                str(e2e_port),
            ]
        )
        rest_api_id = created["id"]
        root_resource_id = created["rootResourceId"]
        resource = lws_invoke(
            [
                "apigateway",
                "create-resource",
                "--rest-api-id",
                rest_api_id,
                "--parent-id",
                root_resource_id,
                "--path-part",
                "temp",
                "--port",
                str(e2e_port),
            ]
        )
        resource_id = resource["id"]
        lws_invoke(
            [
                "apigateway",
                "put-method",
                "--rest-api-id",
                rest_api_id,
                "--resource-id",
                resource_id,
                "--http-method",
                "DELETE",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "apigateway",
                "delete-method",
                "--rest-api-id",
                rest_api_id,
                "--resource-id",
                resource_id,
                "--http-method",
                "DELETE",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
