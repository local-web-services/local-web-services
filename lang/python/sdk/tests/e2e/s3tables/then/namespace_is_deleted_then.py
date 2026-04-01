"""Then: the "s3 tables" "namespace" will be deleted and all its tables will be deleted"""

from __future__ import annotations

from pytest_bdd import then


@then('the "s3 tables" "namespace" will be deleted and all its tables will be deleted')
def namespace_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected namespace delete to succeed but got: {actual_error}"
