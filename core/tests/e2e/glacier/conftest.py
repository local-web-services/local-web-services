"""Shared fixtures for glacier E2E tests."""

from __future__ import annotations

from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


# ── Step definitions ──────────────────────────────────────────────────


@given(
    parsers.parse('a vault "{vault_name}" was created'),
    target_fixture="given_vault",
)
def a_vault_was_created(vault_name, lws_invoke, e2e_port):
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
    return {"vault_name": vault_name}


@when(
    parsers.parse('I create vault "{vault_name}"'),
    target_fixture="command_result",
)
def i_create_vault(vault_name, e2e_port):
    return runner.invoke(
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


@when(
    "I list vaults",
    target_fixture="command_result",
)
def i_list_vaults(e2e_port):
    return runner.invoke(
        app,
        ["glacier", "list-vaults", "--port", str(e2e_port)],
    )


@then(
    parsers.parse('the vault list will include "{vault_name}"'),
)
def the_vault_list_will_include(vault_name, command_result, parse_output):
    data = parse_output(command_result.output)
    actual_names = [v["VaultName"] for v in data["VaultList"]]
    assert vault_name in actual_names


@then(
    parsers.parse('vault "{vault_name}" will exist'),
)
def vault_will_exist(vault_name, assert_invoke, e2e_port):
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
