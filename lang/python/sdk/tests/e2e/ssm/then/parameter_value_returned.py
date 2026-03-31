"""Then: the "ssm" "parameter" value will be returned"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_VALUE


@then('the "ssm" "parameter" value will be returned')
def parameter_value_returned(world):
    assert world["error"] is None, f"Expected get_parameter to succeed but got: {world['error']}"
    param = world["result"]["Parameter"]
    expected_value = TEST_VALUE
    actual_value = param["Value"]
    assert (
        actual_value == expected_value
    ), f"Expected parameter value '{expected_value}' but got '{actual_value}'"
