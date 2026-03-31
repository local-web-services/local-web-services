"""Given: a prod stage is created for an "api gateway" "API" """

from __future__ import annotations

from pytest_bdd import given


@given('a prod stage is created for an "api gateway" "API"')
def prod_stage_created():
    """No-op: stage creation is part of API setup in the test."""
