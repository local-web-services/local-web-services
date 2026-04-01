"""Given: a child "api gateway" "resource" is created under an existing "api gateway" "resource" """

from __future__ import annotations

from pytest_bdd import given


@given('a child "api gateway" "resource" is created under an existing "api gateway" "resource"')
def child_resource_created():
    """No-op: child resource creation is part of API setup in the test."""
