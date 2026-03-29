"""Given: the vault is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the vault is "ACTIVE"')
def vault_is_active_given():
    """No-op: vaults are ACTIVE immediately after creation in lws."""
