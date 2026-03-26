"""Given: the dev stage does not already exist for this "API" """

from __future__ import annotations

from pytest_bdd import given


@given('the dev stage does not already exist for this "API"')
def dev_stage_does_not_exist():
    """No-op: fresh state has no stages."""
