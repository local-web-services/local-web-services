"""Given: the "api gateway" "resource" has a path"""

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "resource" has a path')
def resource_has_path():
    """No-op: resources always have paths in lws."""
