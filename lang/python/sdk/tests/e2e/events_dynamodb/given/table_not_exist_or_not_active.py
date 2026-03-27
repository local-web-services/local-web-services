"""Given: the table does not exist or is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the table does not exist or is not "ACTIVE"')
def table_not_exist_or_not_active(world):
    """No-op: fresh state has no tables."""
    world["result"] = None
    world["error"] = None
