"""Given: the vault is "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the vault is "DELETED"')
def vault_is_deleted_given():
    """No-op: fresh state has no vaults (simulates deleted vault)."""
