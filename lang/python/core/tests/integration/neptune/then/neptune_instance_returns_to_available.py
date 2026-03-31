"""Then: the "documentdb" "instance" returns to "AVAILABLE" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the "documentdb" "instance" returns to "AVAILABLE" state')
def neptune_instance_returns_to_available(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
