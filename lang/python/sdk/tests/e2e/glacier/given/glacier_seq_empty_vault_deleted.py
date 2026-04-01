"""Given: an empty "glacier" "vault" is deleted"""

from __future__ import annotations

from pytest_bdd import given


@given('an empty "glacier" "vault" is deleted')
def glacier_seq_empty_vault_deleted():
    """No-op: fresh state has no vaults, simulates a previously deleted vault."""
