"""Given: a non-root "api gateway" "resource" is deleted along with its methods and integrations"""

from __future__ import annotations

from pytest_bdd import given


@given('a non-root "api gateway" "resource" is deleted along with its methods and integrations')
def non_root_resource_deleted():
    """No-op: resource deletion is part of API setup in the test."""
