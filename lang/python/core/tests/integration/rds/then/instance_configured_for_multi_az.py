"""Then: the "rds" "instance" will be configured for multi-"AZ" deployment"""

from __future__ import annotations

from pytest_bdd import then


@then('the "rds" "instance" will be configured for multi-"AZ" deployment')
def instance_configured_for_multi_az(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected multi-AZ enable to succeed but got error: {world['error']}"
