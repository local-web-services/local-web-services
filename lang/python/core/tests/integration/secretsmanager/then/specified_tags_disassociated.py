"""Then: the specified tags are no longer associated with the secret"""

from __future__ import annotations

from pytest_bdd import then


@then("the specified tags are no longer associated with the secret")
def specified_tags_disassociated(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected untag_resource to succeed but got: {actual_error}"
