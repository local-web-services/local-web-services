"""Given: the bus did not exist or was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "dynamodb" "table" did not exist or was "ACTIVE"')
def table_not_exist_or_not_active(world):
    """No-op: fresh state has no tables."""
    world["result"] = None
    world["error"] = None
