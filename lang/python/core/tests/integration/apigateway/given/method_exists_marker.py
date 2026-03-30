"""Given: the method "EXISTS" """

from __future__ import annotations

from pytest_bdd import given


@given('the method "EXISTS"')
def method_exists_marker():
    """No-op: method existence is set up by other Given steps."""
