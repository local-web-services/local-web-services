"""Given: the "rds" "DB instance" finishes stopping"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DB_INSTANCE


@given('the "rds" "DB instance" finishes stopping')
def rds_events_db_instance_finished_stopping(lws_session):
    lws_session.inject_state("rds", "instance", TEST_DB_INSTANCE, "stopped")
