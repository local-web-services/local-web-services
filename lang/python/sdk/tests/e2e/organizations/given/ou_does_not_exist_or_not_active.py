"""Given: the organizational unit does not exist or is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the organizational unit does not exist or is not "ACTIVE"')
def ou_does_not_exist_or_not_active(world):
    world["ou_id"] = "nonexistent-ou-id"
