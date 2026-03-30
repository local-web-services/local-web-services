"""Given: the vault "EXISTS" """

from __future__ import annotations

from pytest_bdd import given


@given('the vault "EXISTS"')
def vault_exists_given():
    """No-op: Glacier vaults exist immediately after creation."""
