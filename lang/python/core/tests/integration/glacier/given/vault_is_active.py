"""Given: the "glacier" "vault" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "vault" was "ACTIVE"')
def vault_is_active():
    """No-op: vaults are always ACTIVE immediately after creation."""
