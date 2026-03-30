"""Given: the prod stage has been deleted"""

from __future__ import annotations

from pytest_bdd import given


@given("the prod stage has been deleted")
def prod_stage_deleted():
    """No-op: stage deletion is part of API setup in the test."""
