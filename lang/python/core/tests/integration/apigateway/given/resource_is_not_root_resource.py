"""Given: the resource is not the root resource"""

from __future__ import annotations

from pytest_bdd import given


@given("the resource is not the root resource")
def resource_is_not_root_resource():
    """No-op: child resources are created alongside root in lws."""
