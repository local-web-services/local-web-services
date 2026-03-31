"""Given: the "rds" "instance" was "CREATING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsTestClient


@given('the "rds" "instance" was "CREATING"')
def instance_is_creating_given(lws_session):
    RdsTestClient(lws_session).create_db_instance()
