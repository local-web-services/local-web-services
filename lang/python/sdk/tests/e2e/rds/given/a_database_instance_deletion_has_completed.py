"""Given: a "rds" "instance" deletion completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DB


@given('a "rds" "instance" deletion completes')
def a_database_instance_deletion_has_completed(lws_session):
    lws_session.inject_state("rds", "instance", TEST_DB, "deleted")
