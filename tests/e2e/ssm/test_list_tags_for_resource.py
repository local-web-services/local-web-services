from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListTagsForResource:
    def test_list_tags_for_resource(self, e2e_port, lws_invoke):
        # Arrange
        param_name = "/e2e/list-tags-test"
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
                "list-tags-for-resource",
                "--resource-type",
                "Parameter",
                "--resource-id",
                param_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
