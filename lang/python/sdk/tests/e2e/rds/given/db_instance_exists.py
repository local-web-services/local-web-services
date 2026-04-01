"""Given: the "rds" "instance" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsTestClient


@given('the "rds" "instance" existed')
def db_instance_exists(lws_session):
    RdsTestClient(lws_session).create_db_instance()
