"""Then: the definition is valid or invalid"""

from __future__ import annotations

from pytest_bdd import then


@then("the definition is valid or invalid")
def definition_is_valid_or_invalid(world):
    assert (
        world["error"] is None
    ), f"Expected validate_state_machine_definition to succeed but got: {world['error']}"
    assert (
        "result" in world["result"] or "validationErrors" in world["result"]
    ), "Expected 'result' or 'validationErrors' in response"
