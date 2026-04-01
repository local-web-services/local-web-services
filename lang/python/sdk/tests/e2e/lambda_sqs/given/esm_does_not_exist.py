"""Given: the event source mapping did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the event source mapping did not exist")
def esm_does_not_exist():
    """No-op: fresh state has no event source mappings."""
