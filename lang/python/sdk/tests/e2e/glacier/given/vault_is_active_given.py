"""Given: the "glacier" "vault" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "vault" was "ACTIVE"')
def vault_is_active_given():
    """No-op: vaults are ACTIVE immediately after creation in lws."""
