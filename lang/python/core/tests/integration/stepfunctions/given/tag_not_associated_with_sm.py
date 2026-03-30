"""Given: the tag is not associated with the state machine"""

from __future__ import annotations

from pytest_bdd import given


@given("the tag is not associated with the state machine")
def tag_not_associated_with_sm():
    """No-op: a fresh state machine has no tags."""
