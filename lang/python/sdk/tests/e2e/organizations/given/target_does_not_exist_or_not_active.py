"""Given: the "organizations" "target" did not exist or was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "organizations" "target" did not exist or was "ACTIVE"')
def target_does_not_exist_or_not_active(world):
    world["target_id"] = "nonexistent-target"
