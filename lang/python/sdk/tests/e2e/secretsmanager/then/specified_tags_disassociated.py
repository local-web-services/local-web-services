"""Then: the specified tags are no longer associated with the "secrets manager" "secret" """

from __future__ import annotations

from pytest_bdd import then


@then('the specified tags are no longer associated with the "secrets manager" "secret"')
def specified_tags_disassociated(world):
    assert world["error"] is None, f"Expected untag_resource to succeed but got: {world['error']}"
