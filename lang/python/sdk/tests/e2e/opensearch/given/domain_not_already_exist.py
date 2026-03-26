"""Given: the domain does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the domain does not already exist")
def domain_not_already_exist():
    """No-op: fresh state has no domains."""
