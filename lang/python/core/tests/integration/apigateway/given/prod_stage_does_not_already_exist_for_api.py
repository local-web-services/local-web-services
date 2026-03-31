"""Given: the "api gateway" "prod stage" did not already exist for this "API" """

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "prod stage" did not already exist for this "API"')
def prod_stage_does_not_already_exist_for_api():
    """No-op: fresh state has no stages."""
