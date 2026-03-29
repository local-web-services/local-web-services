"""Given: an "API" deployment has been created"""

from __future__ import annotations

from pytest_bdd import given


@given('an "API" deployment has been created')
def api_deployment_created():
    """No-op: deployment is part of API setup in the test."""
