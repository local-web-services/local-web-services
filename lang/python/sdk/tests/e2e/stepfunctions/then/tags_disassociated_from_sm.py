"""Then: the tags are disassociated from the state machine"""

from __future__ import annotations

from pytest_bdd import then


@then("the tags are disassociated from the state machine")
def tags_disassociated_from_sm(world):
    assert world["error"] is None, f"Expected untag_resource to succeed but got: {world['error']}"
