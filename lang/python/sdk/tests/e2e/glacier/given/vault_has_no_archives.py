"""Given: the vault has no archives"""

from __future__ import annotations

from pytest_bdd import given


@given("the vault has no archives")
def vault_has_no_archives():
    """No-op: fresh vault has no archives."""
