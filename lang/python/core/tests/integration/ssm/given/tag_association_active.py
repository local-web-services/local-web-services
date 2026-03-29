"""Given: the tag association is active"""

from __future__ import annotations

from pytest_bdd import given


@given("the tag association is active")
def tag_association_active():
    """No-op: tag associations are always active after creation."""
