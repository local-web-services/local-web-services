"""Given: the vault does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the vault does not exist")
def vault_does_not_exist():
    """No-op: fresh state has no vaults."""
