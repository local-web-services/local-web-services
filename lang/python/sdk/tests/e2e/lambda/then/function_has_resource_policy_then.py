"""Then: the "lambda" "function" has a resource policy"""

from __future__ import annotations

from pytest_bdd import then


@then('the "lambda" "function" has a resource policy')
def function_has_resource_policy_then(world):
    assert world["error"] is None, f"Expected add_permission to succeed but got: {world['error']}"
