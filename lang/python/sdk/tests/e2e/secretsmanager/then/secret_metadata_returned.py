"""Then: the "secrets manager" "secret" metadata will be returned"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_SECRET


@then('the "secrets manager" "secret" metadata will be returned')
def secret_metadata_returned(world):
    assert world["error"] is None, f"Expected describe_secret to succeed but got: {world['error']}"
    expected_name = TEST_SECRET
    actual_name = world["result"].get("Name", "")
    assert (
        actual_name == expected_name
    ), f"Expected secret name '{expected_name}' but got '{actual_name}'"
