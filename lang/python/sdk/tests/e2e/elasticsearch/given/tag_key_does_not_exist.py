"""Given: the "elasticsearch" "tag key" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticsearch" "tag key" did not exist')
def tag_key_does_not_exist():
    """No-op: domains have no tags by default."""
