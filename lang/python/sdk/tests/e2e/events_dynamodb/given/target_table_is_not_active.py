"""Given: the target table is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the target table is not "ACTIVE"')
def target_table_is_not_active():
    """No-op: no table exists, satisfies not-ACTIVE."""
