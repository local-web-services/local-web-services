"""Given: a backend integration has been attached to a method"""

from __future__ import annotations

from pytest_bdd import given


@given("a backend integration has been attached to a method")
def backend_integration_attached():
    """No-op: integration attachment is part of API setup in the test."""
