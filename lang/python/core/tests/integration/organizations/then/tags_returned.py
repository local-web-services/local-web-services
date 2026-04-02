"""Then: the "organizations" tags will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the "organizations" tags will be returned')
def tags_returned(world):
    actual_tags = {t["Key"]: t["Value"] for t in world["result"].get("Tags", [])}
    expected_tags = world["account_tags"]
    assert actual_tags == expected_tags, f"Expected tags {expected_tags} but got {actual_tags}"
