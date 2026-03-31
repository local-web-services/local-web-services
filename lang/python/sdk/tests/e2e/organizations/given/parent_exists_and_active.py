"""Given: the "organizations" "parent" existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "organizations" "parent" existed and was "ACTIVE"')
def parent_exists_and_active():
    """Root is always the default parent; already stored as root_id."""
