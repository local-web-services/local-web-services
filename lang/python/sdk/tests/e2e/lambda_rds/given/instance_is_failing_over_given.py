"""Given: the "rds" "instance" was "FAILING_OVER" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaRdsTestClient


@given('the "rds" "instance" was "FAILING_OVER"')
def instance_is_failing_over_given(lws_session, world):
    LambdaRdsTestClient(lws_session).create_db_cluster()
