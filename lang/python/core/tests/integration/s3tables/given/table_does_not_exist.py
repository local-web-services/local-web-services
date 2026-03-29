"""Given: the table does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the table does not exist")
def table_does_not_exist():
    """No-op: fresh provider has no tables."""
