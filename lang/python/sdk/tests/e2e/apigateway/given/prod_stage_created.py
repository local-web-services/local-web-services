"""Given: a prod stage has been created for an "API" """

from __future__ import annotations

from pytest_bdd import given


@given('a prod stage has been created for an "API"')
def prod_stage_created():
    """No-op: stage creation is part of API setup in the test."""
