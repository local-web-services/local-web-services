"""Given: the namespace does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the namespace does not exist")
def namespace_does_not_exist():
    """No-op: fresh state has no namespaces."""
