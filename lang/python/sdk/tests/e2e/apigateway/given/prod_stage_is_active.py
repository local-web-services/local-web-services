"""Given: the "api gateway" "prod stage" is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "prod stage" is "ACTIVE"')
def prod_stage_is_active():
    """No-op: stages are active immediately after creation."""
