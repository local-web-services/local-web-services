"""E2E test for Cognito forgot-password CLI command."""

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestForgotPassword:
    def test_forgot_and_confirm_resets_password(self, e2e_port, lws_invoke, parse_output):
        # Arrange
        pool_name = "e2e-forgot-pw-pool"
        username = "e2e-forgot-user"
        old_password = "P@ssw0rd!123"
        new_password = "N3wP@ssw0rd!"
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
                old_password,
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

        # Act - initiate forgot password
        forgot_result = runner.invoke(
            app,
            [
                "cognito-idp",
                "forgot-password",
                "--user-pool-name",
                pool_name,
                "--username",
                username,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert - forgot password succeeded
        assert forgot_result.exit_code == 0, forgot_result.output
        forgot_body = parse_output(forgot_result.output)
        assert "CodeDeliveryDetails" in forgot_body

        # Act - confirm forgot password with bad code
        confirm_result = runner.invoke(
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

        # Assert - confirm returns code mismatch error
        assert confirm_result.exit_code == 0
        confirm_body = parse_output(confirm_result.output)
        expected_error = "CodeMismatchException"
        actual_error = confirm_body["__type"]
        assert actual_error == expected_error
