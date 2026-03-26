"""Then: the tags are associated with the parameter"""

from __future__ import annotations

from pytest_bdd import then


@then("the tags are associated with the parameter")
def tags_associated_with_parameter(world):
    assert (
        world["error"] is None
    ), f"Expected add_tags_to_resource to succeed but got: {world['error']}"
