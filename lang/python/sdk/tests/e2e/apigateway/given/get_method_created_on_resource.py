"""Given: a "GET" method has been created on a resource"""

from __future__ import annotations

from pytest_bdd import given


@given('a "GET" method has been created on a resource')
def get_method_created_on_resource():
    """No-op: method creation is part of API setup in the test."""
