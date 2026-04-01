"""Then: the "ssm" "parameter" values will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the "ssm" "parameter" values will be returned')
def parameter_values_returned(world):
    assert world["error"] is None, f"Expected get_parameters to succeed but got: {world['error']}"
    assert "Parameters" in world["result"], "Expected 'Parameters' key in response"
