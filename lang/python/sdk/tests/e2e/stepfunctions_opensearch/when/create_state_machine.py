"""When: a Step Functions state machine is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsOpensearchTestClient
from ..constants import PASS_DEFINITION, ROLE_ARN, TEST_SM


@when("a Step Functions state machine is created")
def create_state_machine(lws_session, world):
    try:
        resp = StepfunctionsOpensearchTestClient(lws_session)._sfn.create_state_machine(
            name=TEST_SM, definition=PASS_DEFINITION, roleArn=ROLE_ARN
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
