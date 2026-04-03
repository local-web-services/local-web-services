"""Given: a "rds" "instance" restore from "rds" "snapshot" completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DB


@given('a "rds" "instance" restore from "rds" "snapshot" completes')
def a_database_instance_restore_from_snapshot_has_completed(lws_session):
    lws_session.inject_state("rds", "instance", TEST_DB, "available")
