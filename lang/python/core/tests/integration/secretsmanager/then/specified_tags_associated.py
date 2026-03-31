"""Then: the specified tags are associated with the "secrets manager" "secret" """

from __future__ import annotations

from pytest_bdd import then


@then('the specified tags are associated with the "secrets manager" "secret"')
def specified_tags_associated(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected tag_resource to succeed but got: {actual_error}"
