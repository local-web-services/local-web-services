"""E2E test for Glacier create-vault CLI command."""

from __future__ import annotations

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateVault:
    def test_create_vault(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        vault_name = "e2e-create-vault"

        # Act
        result = runner.invoke(
            app,
            [
                "glacier",
                "create-vault",
                "--vault-name",
                vault_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(
            [
                "glacier",
                "describe-vault",
                "--vault-name",
                vault_name,
                "--port",
                str(e2e_port),
            ]
        )
        actual_vault_name = verify["VaultName"]
        assert actual_vault_name == vault_name

    def test_create_vault_idempotent(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        vault_name = "e2e-idempotent-vault"
        lws_invoke(
            [
                "glacier",
                "create-vault",
                "--vault-name",
                vault_name,
                "--port",
                str(e2e_port),
            ]
        )

        # Act
        result = runner.invoke(
            app,
            [
                "glacier",
                "create-vault",
                "--vault-name",
                vault_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
