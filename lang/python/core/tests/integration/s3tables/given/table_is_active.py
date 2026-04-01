"""Given: the "dynamodb" "table" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "table" was "ACTIVE"')
@given('the "dynamodb" "table" was "ACTIVE"')
def table_is_active():
    """No-op: in lws, tables are ACTIVE immediately after creation."""
