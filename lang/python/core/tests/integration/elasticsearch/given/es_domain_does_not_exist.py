"""Given: the domain does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the domain does not exist")
def es_domain_does_not_exist():
    """No-op: fresh state has no domains."""
