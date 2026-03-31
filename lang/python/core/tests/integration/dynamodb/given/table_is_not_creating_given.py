"""Given: the "dynamodb" "table" was not "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "dynamodb" "table" was not "CREATING"')
def table_is_not_creating_given():
    """No-op: in lws, created tables are ACTIVE (never CREATING)."""
