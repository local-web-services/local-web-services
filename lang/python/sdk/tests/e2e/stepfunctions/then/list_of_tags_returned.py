"""Then: the list of tags is returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the list of tags is returned")
def list_of_tags_returned(world):
    assert (
        world["error"] is None
    ), f"Expected list_tags_for_resource to succeed but got: {world['error']}"
    assert "tags" in world["result"], "Expected 'tags' key in response"
