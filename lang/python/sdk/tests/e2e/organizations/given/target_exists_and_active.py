"""Given: the target exists and is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the target exists and is "ACTIVE"')
def target_exists_and_active():
    """Root is the target; already stored as root_id / target_id."""
