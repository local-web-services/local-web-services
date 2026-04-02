"""Given: the "rds" "instance" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsEventsTestClient


@given('the "rds" "instance" already existed')
def db_instance_already_exists(lws_session):
    RdsEventsTestClient(lws_session).create_db_instance()
