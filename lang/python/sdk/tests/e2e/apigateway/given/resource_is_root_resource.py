"""Given: the "api gateway" "resource" is the root "api gateway" "resource" """

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "resource" is the root "api gateway" "resource"')
def resource_is_root_resource(lws_session):
    """No-op: root resource is created implicitly with each REST API."""
