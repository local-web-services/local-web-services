"""Given: the "glacier" "vault" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "vault" did not already exist')
def vault_not_already_exist():
    """No-op: fresh state has no vaults."""
