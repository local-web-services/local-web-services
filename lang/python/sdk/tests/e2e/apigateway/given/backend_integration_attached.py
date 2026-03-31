"""Given: a backend integration is attached to a "api gateway" "method" """

from __future__ import annotations

from pytest_bdd import given


@given('a backend integration is attached to a "api gateway" "method"')
def backend_integration_attached():
    """No-op: integration attachment is part of API setup in the test."""
