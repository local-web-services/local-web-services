"""Given: the bus does not exist or is "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the bus does not exist or is "DELETED"')
def bus_not_exist_or_deleted():
    """No-op: fresh state has no event buses."""
