"""Given: the vault is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the vault is "ACTIVE"')
def vault_is_active():
    """No-op: vaults are always ACTIVE immediately after creation."""
