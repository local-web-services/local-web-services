"""Given: the target does not exist or is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the target does not exist or is not "ACTIVE"')
def target_does_not_exist_or_not_active(world):
    world["target_id"] = "nonexistent-target"
