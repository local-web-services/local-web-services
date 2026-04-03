"""Given: a "rds" "instance" modification completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DB


@given('a "rds" "instance" modification completes')
def a_database_instance_modification_has_completed(lws_session):
    lws_session.inject_state("rds", "instance", TEST_DB, "available")
