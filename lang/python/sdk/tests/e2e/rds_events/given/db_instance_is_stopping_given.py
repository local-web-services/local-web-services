"""Given: the "rds" "DB instance" was "STOPPING" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_DB_INSTANCE


@given('the "rds" "DB instance" was "STOPPING"')
def db_instance_is_stopping_given(lws_session):
    lws_session.inject_state("rds", "instance", TEST_DB_INSTANCE, "stopping")
