"""Then: the bucket is "DELETED" and all its namespaces and tables are "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the bucket is "DELETED" and all its namespaces and tables are "DELETED"')
def bucket_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table bucket delete to succeed but got: {actual_error}"
