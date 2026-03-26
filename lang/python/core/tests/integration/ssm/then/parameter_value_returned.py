"""Then: the parameter value is returned"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import INT_VALUE


@then("the parameter value is returned")
def parameter_value_returned(world):
    assert world["error"] is None, f"Expected get_parameter to succeed but got: {world['error']}"
    param = world["result"]["Parameter"]
    expected_value = INT_VALUE
    actual_value = param["Value"]
    assert (
        actual_value == expected_value
    ), f"Expected parameter value '{expected_value}' but got '{actual_value}'"
