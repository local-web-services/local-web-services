"""Given: an empty vault has been deleted"""

from __future__ import annotations

from pytest_bdd import given


@given("an empty vault has been deleted")
def glacier_seq_empty_vault_deleted():
    """No-op: fresh state has no vaults, simulates a previously deleted vault."""
