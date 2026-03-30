"""Then: the table has a policy"""

from __future__ import annotations

from pytest_bdd import then


@then("the table has a policy")
def table_has_a_policy_then(world: dict):
    actual_result = world["result"]
    assert actual_result is not None, "Expected table to have a policy but got no result"
