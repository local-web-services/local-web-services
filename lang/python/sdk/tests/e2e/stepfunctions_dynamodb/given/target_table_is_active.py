"""Given: the target "dynamodb" "table" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the target "dynamodb" "table" was "ACTIVE"')
def target_table_is_active():
    """No-op: tables are ACTIVE immediately after creation."""
