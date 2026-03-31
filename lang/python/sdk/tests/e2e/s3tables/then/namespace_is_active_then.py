"""Then: the "s3 tables" "namespace" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then


@then('the "s3 tables" "namespace" will be "ACTIVE"')
def namespace_is_active_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected namespace creation to succeed but got: {actual_error}"
