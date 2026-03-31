"""Given: the "memorydb" "resource" does not have a tag entry"""

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "resource" does not have a tag entry')
def resource_does_not_have_tag_entry_guard():
    """No-op: fresh resources have no tags."""
