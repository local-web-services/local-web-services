"""Given: the prod stage does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the prod stage does not exist")
def prod_stage_does_not_exist_v2():
    """No-op: fresh state has no stages."""
