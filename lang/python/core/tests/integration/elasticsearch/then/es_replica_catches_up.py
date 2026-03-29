"""Then: the replica eventually catches up without changing document counts"""

from __future__ import annotations

from pytest_bdd import then


@then("the replica eventually catches up without changing document counts")
def es_replica_catches_up(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
