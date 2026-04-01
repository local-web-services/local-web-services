"""Given: the "api gateway" "prod stage" does not have throttling configured"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "prod stage" does not have throttling configured')
def dev_stage_does_not_have_throttling_configured():
    """No-op: no throttling configured by default."""
