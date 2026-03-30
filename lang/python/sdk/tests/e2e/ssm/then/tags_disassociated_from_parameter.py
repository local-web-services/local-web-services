"""Then: the tags are disassociated from the parameter"""

from __future__ import annotations

from pytest_bdd import then


@then("the tags are disassociated from the parameter")
def tags_disassociated_from_parameter(world):
    assert (
        world["error"] is None
    ), f"Expected remove_tags_from_resource to succeed but got: {world['error']}"
