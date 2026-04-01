"""Given: vault not in vault_status"""

from __future__ import annotations

from pytest_bdd import given


@given("vault not in vault_status")
def vault_not_in_vault_status():
    """No-op: fresh state has no vaults."""
