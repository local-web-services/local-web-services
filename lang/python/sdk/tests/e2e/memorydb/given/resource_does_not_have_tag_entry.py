"""Given: the "memorydb" "resource" does not have a tag entry"""

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "resource" was not tagged')
def resource_does_not_have_tag_entry():
    """No-op: fresh resources have no tags."""
