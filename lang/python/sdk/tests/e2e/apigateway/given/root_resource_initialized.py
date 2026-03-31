"""Given: a root resource is initialized for an "api gateway" "API" """

from __future__ import annotations

from pytest_bdd import given


@given('a root resource is initialized for an "api gateway" "API"')
def root_resource_initialized():
    """No-op: root resource is always present after API creation."""
