"""Given: the parent exists and is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the parent exists and is "ACTIVE"')
def parent_exists_and_active(world):
    """Root is always the default parent; already stored as root_id."""
