"""Then: the tags are associated with the state machine"""

from __future__ import annotations

from pytest_bdd import then


@then("the tags are associated with the state machine")
def tags_associated_with_sm(world):
    assert world["error"] is None, f"Expected tag_resource to succeed but got: {world['error']}"
