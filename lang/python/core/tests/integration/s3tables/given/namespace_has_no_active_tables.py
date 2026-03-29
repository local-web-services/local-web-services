"""Given: the namespace has no active tables"""

from __future__ import annotations

from pytest_bdd import given


@given("the namespace has no active tables")
def namespace_has_no_active_tables():
    """No-op: fresh namespace has no tables."""
