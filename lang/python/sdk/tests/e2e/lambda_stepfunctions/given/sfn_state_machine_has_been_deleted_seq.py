"""Given: a Step Functions state machine has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaStepfunctionsTestClient
from ..constants import _sm_arn


@given("a Step Functions state machine has been deleted")
def sfn_state_machine_has_been_deleted_seq(lws_session):
    try:
        LambdaStepfunctionsTestClient(lws_session).create_sm()
    except Exception:
        pass
    LambdaStepfunctionsTestClient(lws_session)._sfn.delete_state_machine(stateMachineArn=_sm_arn())
