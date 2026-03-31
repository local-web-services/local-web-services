"""Given: the target "dynamodb" "table" was not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the target "dynamodb" "table" was not "DELETING"')
def target_table_is_not_deleting():
    """No-op: tables are never in DELETING state in lws."""
