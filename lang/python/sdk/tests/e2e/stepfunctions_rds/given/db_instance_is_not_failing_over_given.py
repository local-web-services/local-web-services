"""Given: the "rds" "DB instance" was not "FAILING_OVER" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsRdsTestClient


@given('the "rds" "DB instance" was not "FAILING_OVER"')
def db_instance_is_not_failing_over_given(lws_session):
    StepfunctionsRdsTestClient(lws_session).create_cluster()
