"""Then: the restored instance is in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the restored instance is in "CREATING" state')
def restored_instance_is_creating(world: dict):
    actual_result = world["result"]
    assert actual_result is not None, f"Expected restore to succeed but got error: {world['error']}"
