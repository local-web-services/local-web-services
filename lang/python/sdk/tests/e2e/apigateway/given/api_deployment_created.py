"""Given: an "api gateway" "API" deployment is created"""

from __future__ import annotations

from pytest_bdd import given


@given('an "api gateway" "API" deployment is created')
def api_deployment_created():
    """No-op: deployment is part of API setup in the test."""
