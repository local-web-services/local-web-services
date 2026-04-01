"""Then: the current "secrets manager" "secret" value will be returned"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_VALUE


@then('the current "secrets manager" "secret" value will be returned')
def current_secret_value_returned(world):
    assert world["error"] is None, f"Expected get_secret_value to succeed but got: {world['error']}"
    expected_value = TEST_VALUE
    actual_value = world["result"].get("SecretString", "")
    assert (
        actual_value == expected_value
    ), f"Expected secret value '{expected_value}' but got '{actual_value}'"
