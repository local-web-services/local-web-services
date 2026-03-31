"""Given: the "api gateway" "prod stage" is redeployed to a new deployment"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "prod stage" is redeployed to a new deployment')
def prod_stage_redeployed():
    """No-op: stage redeployment is part of API setup in the test."""
