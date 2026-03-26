"""Given: the integrated state machine is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayStepfunctionsTestClient


@given('the integrated state machine is "ACTIVE"')
def apigw_sfn_integrated_sm_is_active(lws_session):
    try:
        ApigatewayStepfunctionsTestClient(lws_session).create_sm()
    except Exception:
        pass
