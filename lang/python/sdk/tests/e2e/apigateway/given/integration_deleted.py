"""Given: an integration has been deleted"""

from __future__ import annotations

from pytest_bdd import given


@given("an integration has been deleted")
def integration_deleted():
    """No-op: integration deletion is part of API setup in the test."""
