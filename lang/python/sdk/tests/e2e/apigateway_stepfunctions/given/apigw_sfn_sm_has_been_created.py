"""Given: a "step functions" "Express Workflow state machine" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayStepfunctionsTestClient


@given('a "step functions" "Express Workflow state machine" is created')
def apigw_sfn_sm_has_been_created(lws_session):
    ApigatewayStepfunctionsTestClient(lws_session).create_sm()
