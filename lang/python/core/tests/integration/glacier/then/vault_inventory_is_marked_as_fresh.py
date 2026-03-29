"""Then: the vault inventory is marked as fresh"""

from __future__ import annotations

from pytest_bdd import then


@then("the vault inventory is marked as fresh")
def vault_inventory_is_marked_as_fresh(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected inventory refresh to succeed but got: {actual_error}"
