"""Given: the "step functions" "state machine" already has a "lambda" task configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsLambdaTestClient
from ..constants import LAMBDA_DEFINITION


@given('the "step functions" "state machine" already has a "lambda" task configured')
def sm_already_has_lambda_task_given(lws_session):
    try:
        StepfunctionsLambdaTestClient(lws_session).create_sm(definition=LAMBDA_DEFINITION)
    except Exception:
        pass
