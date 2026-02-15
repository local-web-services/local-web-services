import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteParameters:
    def test_delete_parameters(self, e2e_port, lws_invoke):
        # Arrange
        param_name = "/e2e/del-params-test"
        lws_invoke(
            [
                "ssm",
                "put-parameter",
                "--name",
                param_name,
                "--value",
                "val1",
                "--type",
                "String",
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "ssm",
                "delete-parameters",
                "--names",
                json.dumps([param_name]),
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
