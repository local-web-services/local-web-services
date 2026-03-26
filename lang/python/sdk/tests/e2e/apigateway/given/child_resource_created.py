"""Given: a child resource has been created under an existing resource"""

from __future__ import annotations

from pytest_bdd import given


@given("a child resource has been created under an existing resource")
def child_resource_created():
    """No-op: child resource creation is part of API setup in the test."""
