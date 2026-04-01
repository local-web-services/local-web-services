"""Given: the delivery did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the delivery did not exist")
def delivery_does_not_exist():
    """No-op: fresh provider state has no in-flight deliveries."""
