"""Given: a deployment has been deleted when no stage references it"""

from __future__ import annotations

from pytest_bdd import given


@given("a deployment has been deleted when no stage references it")
def deployment_deleted_when_no_stage():
    """No-op: deployment deletion is part of API setup in the test."""
