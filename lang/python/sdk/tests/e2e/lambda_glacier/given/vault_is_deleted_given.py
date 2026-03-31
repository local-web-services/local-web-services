"""Given: the "glacier" "vault" was "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "vault" was "DELETED"')
def vault_is_deleted_given():
    """No-op: fresh state has no vaults (simulates deleted vault)."""
