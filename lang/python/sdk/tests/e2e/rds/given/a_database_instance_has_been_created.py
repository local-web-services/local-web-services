"""Given: a "rds" "instance" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsTestClient


@given('a "rds" "instance" is created')
def a_database_instance_has_been_created(lws_session):
    RdsTestClient(lws_session).create_db_instance()
