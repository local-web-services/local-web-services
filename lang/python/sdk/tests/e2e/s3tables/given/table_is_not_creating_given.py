"""Given: the table is not "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the table is not "CREATING"')
def table_is_not_creating_given():
    """No-op: tables are not in CREATING state by default."""
