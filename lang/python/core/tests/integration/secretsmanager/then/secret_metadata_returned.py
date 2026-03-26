"""Then: the secret metadata is returned"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import INT_SECRET


@then("the secret metadata is returned")
def secret_metadata_returned(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected describe_secret to succeed but got: {actual_error}"
    expected_name = INT_SECRET
    actual_name = world["result"].get("Name", "")
    assert (
        actual_name == expected_name
    ), f"Expected secret name '{expected_name}' but got '{actual_name}'"
