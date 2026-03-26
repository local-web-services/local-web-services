"""Given: eid in exec_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaStepfunctionsTestClient
from ..constants import _sm_arn


@given("eid in exec_status")
def eid_in_exec_status(lws_session):
    LambdaStepfunctionsTestClient(lws_session).create_sm()
    LambdaStepfunctionsTestClient(lws_session)._sfn.start_execution(
        stateMachineArn=_sm_arn(), input='{"key": "value"}'
    )
