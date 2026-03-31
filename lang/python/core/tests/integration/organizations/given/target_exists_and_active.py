"""Given: the "organizations" "target" existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "organizations" "target" existed and was "ACTIVE"')
def target_exists_and_active(world):
    """Root is the target; already stored as root_id / target_id."""
