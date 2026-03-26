"""Then: the specified tags are no longer associated with the domain"""

from __future__ import annotations

from pytest_bdd import then


@then("the specified tags are no longer associated with the domain")
def es_specified_tags_not_associated_with_domain(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected tag removal to succeed but got error: {world['error']}"
