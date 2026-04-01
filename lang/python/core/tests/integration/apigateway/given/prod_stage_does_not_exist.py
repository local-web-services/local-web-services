"""Given: the "api gateway" "prod stage" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "prod stage" did not exist')
def prod_stage_does_not_exist():
    """No-op: fresh state has no stages."""
