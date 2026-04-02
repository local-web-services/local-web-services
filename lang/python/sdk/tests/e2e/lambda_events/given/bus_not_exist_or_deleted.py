"""Given: the "eventbridge" "bus" did not exist or was "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "eventbridge" "bus" did not exist or was "DELETED"')
def bus_not_exist_or_deleted():
    """No-op: fresh state has no event buses."""
