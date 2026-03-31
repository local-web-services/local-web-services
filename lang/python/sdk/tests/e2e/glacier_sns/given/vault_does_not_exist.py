"""Given: the "glacier" "vault" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "vault" did not exist')
def vault_does_not_exist():
    """No-op: fresh state has no vaults."""
