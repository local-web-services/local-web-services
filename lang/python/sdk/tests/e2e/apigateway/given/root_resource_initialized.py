"""Given: a root resource has been initialized for an "API" """

from __future__ import annotations

from pytest_bdd import given


@given('a root resource has been initialized for an "API"')
def root_resource_initialized():
    """No-op: root resource is always present after API creation."""
