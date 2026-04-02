"""Then: the "documentdb" "snapshot" will be "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import then


@then('the "documentdb" "snapshot" will be "AVAILABLE"')
def neptune_snapshot_is_available_then(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
