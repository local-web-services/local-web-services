"""Given: the state machine has a Lambda task configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsLambdaTestClient
from ..constants import LAMBDA_DEFINITION, _sm_arn


@given("the state machine has a Lambda task configured")
def sm_has_lambda_task_given(lws_session):
    try:
        StepfunctionsLambdaTestClient(lws_session).create_function()
    except Exception:
        pass
    try:
        StepfunctionsLambdaTestClient(lws_session).create_sm(definition=LAMBDA_DEFINITION)
    except Exception:
        try:
            StepfunctionsLambdaTestClient(lws_session)._sfn.update_state_machine(
                stateMachineArn=_sm_arn(), definition=LAMBDA_DEFINITION
            )
        except Exception:
            pass
