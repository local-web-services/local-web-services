"""Given: the "glacier" "vault" did not exist or was "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "vault" did not exist or was "DELETED"')
def vault_not_exist_or_deleted():
    """No-op: fresh state has no vaults."""
