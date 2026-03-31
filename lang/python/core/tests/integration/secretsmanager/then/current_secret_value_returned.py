"""Then: the current "secrets manager" "secret" value will be returned"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import INT_VALUE


@then('the current "secrets manager" "secret" value will be returned')
def current_secret_value_returned(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected get_secret_value to succeed but got: {actual_error}"
    expected_value = INT_VALUE
    actual_value = world["result"].get("SecretString", "")
    assert (
        actual_value == expected_value
    ), f"Expected secret value '{expected_value}' but got '{actual_value}'"
