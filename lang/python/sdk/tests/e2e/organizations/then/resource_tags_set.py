"""Then: the "organizations" resource tags will be set"""

from __future__ import annotations

from pytest_bdd import then


@then('the "organizations" resource tags will be set')
def resource_tags_set(world):
    # Assert
    assert world["error"] is None, f"Expected tag_resource to succeed but got: {world['error']}"
