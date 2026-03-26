"""Given: the resource is the root resource"""

from __future__ import annotations

from pytest_bdd import given


@given("the resource is the root resource")
def resource_is_root_resource(lws_session):
    """No-op: root resource is created implicitly with each REST API."""
