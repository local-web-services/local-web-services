"""E2E test for Glacier list-vaults CLI command."""

from __future__ import annotations

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListVaults:
    def test_list_vaults(self, e2e_port, lws_invoke, assert_invoke, parse_output):
        # Arrange
        vault_name = "e2e-list-vaults"
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
                "list-vaults",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        data = parse_output(result.output)
        actual_names = [v["VaultName"] for v in data["VaultList"]]
        assert vault_name in actual_names
