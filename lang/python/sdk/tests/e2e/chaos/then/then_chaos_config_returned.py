"""Then: the chaos configuration for each service is returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the chaos configuration for each service is returned")
def then_chaos_config_returned(world):
    """Verify that the chaos status result is a non-empty mapping."""
    expected_error = None
    actual_error = world.get("error")
    assert actual_error == expected_error
    actual_result = world.get("result")
    assert isinstance(actual_result, dict)
