"""Then: all REST APIs are listed"""

from __future__ import annotations

from pytest_bdd import then


@then("all REST APIs are listed")
def all_rest_apis_listed_then(world):
    expected_field = "items"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected REST API list with 'items' key but got: {actual_result}"
