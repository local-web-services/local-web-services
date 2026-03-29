"""Given: the database instance is not "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaRdsTestClient


@given('the database instance is not "AVAILABLE"')
def db_instance_is_not_available_given(lws_session, world):
    LambdaRdsTestClient(lws_session).create_db_cluster()
