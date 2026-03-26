"""Given: the parent resource does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the parent resource does not exist")
def parent_resource_does_not_exist():
    """No-op: fresh state has no REST APIs or resources."""
