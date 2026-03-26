"""Given: the state machine is not "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaStepfunctionsTestClient


@given('the state machine is not "DELETED"')
def sm_is_not_deleted_given(lws_session):
    LambdaStepfunctionsTestClient(lws_session).create_sm()
