"""Given: the "glacier" "vault" existed (not already "DELETED")"""

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "vault" existed (not already "DELETED")')
def vault_exists_not_deleted_given():
    """No-op: Glacier vaults exist and are not deleted immediately after creation."""
