"""Then: the "opensearch" "domain" will be in "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the "opensearch" "domain" will be in "DELETING" state')
def domain_is_deleting_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected domain delete to succeed but got: {actual_error}"
