"""Given: the parent "api gateway" "resource" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the parent "api gateway" "resource" did not exist')
def parent_resource_does_not_exist():
    """No-op: fresh state has no REST APIs or resources."""
