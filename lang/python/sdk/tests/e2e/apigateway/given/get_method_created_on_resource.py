"""Given: a "GET" method is created on a "api gateway" "resource" """

from __future__ import annotations

from pytest_bdd import given


@given('a "GET" method is created on a "api gateway" "resource"')
def get_method_created_on_resource():
    """No-op: method creation is part of API setup in the test."""
