"""Given: the index does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the index does not exist")
def es_index_does_not_exist():
    """No-op: fresh state has no indexes."""
