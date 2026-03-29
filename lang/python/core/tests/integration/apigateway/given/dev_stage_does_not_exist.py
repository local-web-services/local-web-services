"""Given: the dev stage does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the dev stage does not exist")
def dev_stage_does_not_exist():
    """No-op: fresh state has no stages."""
