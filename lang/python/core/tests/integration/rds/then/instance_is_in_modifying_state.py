"""Then: the "documentdb" "INSTANCE" will be in "MODIFYING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the "rds" "instance" will be in "MODIFYING" state')
@then('the "documentdb" "INSTANCE" will be in "MODIFYING" state')
def instance_is_in_modifying_state(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected instance modification to succeed but got error: {world['error']}"
