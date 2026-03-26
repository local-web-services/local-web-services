"""Given: the database instance exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsTestClient


@given("the database instance exists")
def db_instance_exists(lws_session):
    RdsTestClient(lws_session).create_db_instance()
