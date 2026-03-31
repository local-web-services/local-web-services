"""Then: the "s3 tables" "table" has no policy"""

from __future__ import annotations

from pytest_bdd import then


@then('the "s3 tables" "table" has no policy')
def table_has_no_policy_then(world: dict):
    actual_error = world["error"]
    assert actual_error is None, f"Expected table to have no policy but got error: {actual_error}"
