"""Given: a non-root resource has been deleted along with its methods and integrations"""

from __future__ import annotations

from pytest_bdd import given


@given("a non-root resource has been deleted along with its methods and integrations")
def non_root_resource_deleted():
    """No-op: resource deletion is part of API setup in the test."""
