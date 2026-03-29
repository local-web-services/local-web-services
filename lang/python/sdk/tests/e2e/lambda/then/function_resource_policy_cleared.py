"""Then: the function's resource policy is cleared"""

from __future__ import annotations

from pytest_bdd import then


@then("the function's resource policy is cleared")
def function_resource_policy_cleared(world):
    assert (
        world["error"] is None
    ), f"Expected remove_permission to succeed but got: {world['error']}"
