"""Given: the "eventbridge" "bus" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "eventbridge" "bus" did not exist')
def events_lambda_bus_does_not_exist():
    """No-op: fresh state has no event buses."""
