"""Given: the event source mapping did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the event source mapping did not already exist")
def esm_not_already_exist():
    """No-op: fresh state has no event source mappings."""
