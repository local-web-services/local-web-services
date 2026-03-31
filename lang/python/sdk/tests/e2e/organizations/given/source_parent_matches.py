"""Given: the source parent matched the "organizations" "account"'s current parent"""

from __future__ import annotations

from pytest_bdd import given


@given('the source parent matched the "organizations" "account"\'s current parent')
def source_parent_matches(world):
    """Account starts under root; source_parent is already root_id."""
    world["source_parent_id"] = world["root_id"]
