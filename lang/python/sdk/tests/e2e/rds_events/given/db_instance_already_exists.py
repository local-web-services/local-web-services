"""Given: the "DB" instance already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsEventsTestClient


@given('the "DB" instance already exists')
def db_instance_already_exists(lws_session):
    RdsEventsTestClient(lws_session).create_db_instance()
