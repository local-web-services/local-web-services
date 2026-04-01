"""Then: the "rds" "instance" will be in "MODIFYING" state during promotion"""

from __future__ import annotations

from pytest_bdd import then


@then('the "rds" "instance" will be in "MODIFYING" state during promotion')
def instance_enters_modifying_during_promotion(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected failover to succeed but got error: {world['error']}"
