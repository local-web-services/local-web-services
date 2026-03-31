"""Given: a "rds" "instance" finishes creating"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DB


@given('a "rds" "instance" finishes creating')
def a_database_instance_has_finished_creating(lws_session):
    lws_session.inject_state("rds", "instance", TEST_DB, "available")
