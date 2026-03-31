"""Given: a "step functions" "execution" was "RUNNING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaStepfunctionsTestClient
from ..constants import _sm_arn


@given('a "step functions" "execution" was "RUNNING"')
def execution_is_running_given(lws_session):
    LambdaStepfunctionsTestClient(lws_session).create_sm()
    LambdaStepfunctionsTestClient(lws_session)._sfn.start_execution(
        stateMachineArn=_sm_arn(), input='{"key": "value"}'
    )
