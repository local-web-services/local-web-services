"""Given: a "RDS" "DB" instance is created and becomes "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsEventsTestClient


@given('a "RDS" "DB" instance is created and becomes "AVAILABLE"')
def rds_db_instance_created_and_available(lws_session):
    RdsEventsTestClient(lws_session).create_db_instance()
