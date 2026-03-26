"""Given: the target association is active."""

from __future__ import annotations

from pytest_bdd import given


@given("the target association is active")
def target_association_active():
    """No-op: target associations are always active after creation."""
