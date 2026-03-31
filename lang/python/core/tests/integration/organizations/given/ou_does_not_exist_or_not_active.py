"""Given: the "organizations" "organizational unit" did not exist or was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "organizations" "organizational unit" did not exist or was "ACTIVE"')
def ou_does_not_exist_or_not_active(world):
    world["ou_id"] = "nonexistent-ou-id"
