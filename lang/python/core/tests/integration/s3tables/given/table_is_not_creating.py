"""Given: the table is not "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the table is not "CREATING"')
def table_is_not_creating():
    """No-op: in lws, tables are ACTIVE (never CREATING) after creation."""
