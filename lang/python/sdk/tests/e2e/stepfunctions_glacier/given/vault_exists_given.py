"""Given: the "glacier" "vault" will exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "vault" will exist')
def vault_exists_given():
    """No-op: Glacier vaults exist immediately after creation."""
