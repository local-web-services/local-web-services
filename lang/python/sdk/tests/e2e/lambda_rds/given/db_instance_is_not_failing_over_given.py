"""Given: the database instance is not "FAILING_OVER" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaRdsTestClient


@given('the database instance is not "FAILING_OVER"')
def db_instance_is_not_failing_over_given(lws_session):
    LambdaRdsTestClient(lws_session).create_db_cluster()
