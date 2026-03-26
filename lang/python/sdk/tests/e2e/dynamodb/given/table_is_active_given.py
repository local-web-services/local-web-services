"""Given: the table is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the table is "ACTIVE"')
def table_is_active_given(lws_session):
    """No-op: in lws, tables are ACTIVE immediately after creation."""
