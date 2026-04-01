"""Given: the "dynamodb" "table" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "dynamodb" "table" was "ACTIVE"')
def table_is_active_given():
    """No-op: in lws, tables are ACTIVE immediately after creation."""
