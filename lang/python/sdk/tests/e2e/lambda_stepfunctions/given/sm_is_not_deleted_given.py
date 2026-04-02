"""Given: the "step functions" "state machine" is already "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaStepfunctionsTestClient


@given('the "step functions" "state machine" was not "DELETED"')
def sm_is_not_deleted_given(lws_session):
    LambdaStepfunctionsTestClient(lws_session).create_sm()
