"""Given: the "s3 tables" "table" was not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "table" was not "DELETING"')
def table_is_not_deleting_given():
    """No-op: tables are not in DELETING state by default."""
