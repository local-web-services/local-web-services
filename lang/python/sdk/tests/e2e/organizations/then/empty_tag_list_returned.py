"""Then: an empty "organizations" tag list will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('an empty "organizations" tag list will be returned')
def empty_tag_list_returned(world):
    assert world["error"] is None, f"Expected success but got: {world['error']}"
    actual_tags = world["result"].get("Tags")
    expected_tags: list = []
    assert actual_tags == expected_tags, f"Expected empty tag list but got {actual_tags}"
