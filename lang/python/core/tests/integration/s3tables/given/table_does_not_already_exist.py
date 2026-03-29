"""Given: the table does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the table does not already exist")
def table_does_not_already_exist():
    """No-op: fresh namespace has no tables."""
