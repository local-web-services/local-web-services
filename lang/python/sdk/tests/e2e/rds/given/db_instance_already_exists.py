"""Given: the database instance already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsTestClient


@given("the database instance already exists")
def db_instance_already_exists(lws_session):
    RdsTestClient(lws_session).create_db_instance()
