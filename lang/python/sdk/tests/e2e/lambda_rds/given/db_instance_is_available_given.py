"""Given: the "rds" "database instance" was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaRdsTestClient


@given('the "rds" "database instance" was "AVAILABLE"')
def db_instance_is_available_given(lws_session):
    LambdaRdsTestClient(lws_session).create_db_cluster()
