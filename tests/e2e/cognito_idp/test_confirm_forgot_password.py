"""E2E test for Cognito confirm-forgot-password CLI command."""

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestConfirmForgotPassword:
    def test_confirm_forgot_password_with_bad_code(self, e2e_port, lws_invoke, parse_output):
        # Arrange
        pool_name = "e2e-cfp-pool"
        username = "e2e-cfp-user"
        password = "P@ssw0rd!123"
        new_password = "N3wP@ss!456"
        lws_invoke(
            [
                "cognito-idp",
                "create-user-pool",
                "--pool-name",
                pool_name,
                "--port",
                str(e2e_port),
            ]
        )
        lws_invoke(
            [
                "cognito-idp",
                "sign-up",
                "--user-pool-name",
                pool_name,
                "--username",
                username,
                "--password",
                password,
                "--port",
                str(e2e_port),
            ]
        )
        lws_invoke(
            [
                "cognito-idp",
                "confirm-sign-up",
                "--user-pool-name",
                pool_name,
                "--username",
                username,
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "cognito-idp",
                "confirm-forgot-password",
                "--user-pool-name",
                pool_name,
                "--username",
                username,
                "--confirmation-code",
                "000000",
                "--password",
                new_password,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0
        body = parse_output(result.output)
        expected_error = "CodeMismatchException"
        actual_error = body["__type"]
        assert actual_error == expected_error
