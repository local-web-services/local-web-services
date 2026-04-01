"""Then: the specified tags are associated with the "elasticsearch" "domain" """

from __future__ import annotations

from pytest_bdd import then


@then('the specified tags are associated with the "elasticsearch" "domain"')
def tags_associated_then(world):
    expected_error = None
    actual_error = world["error"]
    assert actual_error is expected_error, f"Expected add_tags to succeed but got: {actual_error}"
