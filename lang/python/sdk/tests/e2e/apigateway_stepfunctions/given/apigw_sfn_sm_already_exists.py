"""Given: the "step functions" "state machine" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayStepfunctionsTestClient


@given('the "step functions" "state machine" already existed')
def apigw_sfn_sm_already_exists(lws_session):
    ApigatewayStepfunctionsTestClient(lws_session).create_sm()
