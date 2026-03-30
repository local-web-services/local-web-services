"""Then: the vault inventory is marked as fresh"""

from __future__ import annotations

from pytest_bdd import then


@then("the vault inventory is marked as fresh")
def vault_inventory_marked_fresh_then(world):
    expected_error = None
    actual_error = world.get("error")
    assert (
        actual_error is expected_error
    ), f"Expected vault inventory refresh to succeed but got: {actual_error}"
    expected_refreshed = True
    actual_refreshed = world.get("inventory_refreshed")
    assert (
        actual_refreshed == expected_refreshed
    ), f"Expected inventory_refreshed={expected_refreshed!r} but got: {actual_refreshed!r}"
