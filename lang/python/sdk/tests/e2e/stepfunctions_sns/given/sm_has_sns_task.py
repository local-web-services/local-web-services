"""Given: the state machine has an "SNS" task configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSnsTestClient
from ..constants import ROLE_ARN, TEST_SM, TEST_TOPIC, _sm_arn, _sns_task_definition


@given('the state machine has an "SNS" task configured')
def sm_has_sns_task(lws_session):
    """Create a state machine with an SNS publish task; update if it already exists."""
    try:
        StepfunctionsSnsTestClient(lws_session).create_topic()
    except Exception:
        pass
    try:
        StepfunctionsSnsTestClient(lws_session)._sfn.create_state_machine(
            name=TEST_SM, definition=_sns_task_definition(TEST_TOPIC), roleArn=ROLE_ARN
        )
    except Exception:
        StepfunctionsSnsTestClient(lws_session)._sfn.update_state_machine(
            stateMachineArn=_sm_arn(), definition=_sns_task_definition(TEST_TOPIC)
        )
