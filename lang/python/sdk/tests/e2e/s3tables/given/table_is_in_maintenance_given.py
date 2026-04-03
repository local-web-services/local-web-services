"""Given: the "s3 tables" "table" was in "MAINTENANCE" state"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_TABLE


@given('the "s3 tables" "table" was in "MAINTENANCE" state')
def table_is_in_maintenance_given(lws_session):
    lws_session.inject_state("s3tables", "table", TEST_TABLE, "maintenance")
