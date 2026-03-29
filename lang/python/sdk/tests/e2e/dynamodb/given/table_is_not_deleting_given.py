"""Given: the table is not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the table is not "DELETING"')
def table_is_not_deleting_given():
    """No-op: in lws, tables are ACTIVE immediately after creation (never DELETING)."""
