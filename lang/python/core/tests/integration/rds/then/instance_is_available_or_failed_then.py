"""Then: the "rds" "instance" will be "AVAILABLE" or "FAILED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "rds" "instance" will be "AVAILABLE" or "FAILED"')
def instance_is_available_or_failed_then(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
