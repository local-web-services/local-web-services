"""Given: the "organizations" "policy" did not exist or was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "organizations" "policy" did not exist or was "ACTIVE"')
def policy_does_not_exist_or_not_active(world):
    world["policy_id"] = "nonexistent-policy-id"
    world["target_id"] = "nonexistent-target"
