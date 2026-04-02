"""When: a cloudformation stack is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_STACK_NAME


@when("a cloudformation stack is created")
@when('a "cloudformation" "stack" is created')
def create_stack(lws_session, world):
    try:
        result = lws_session.client("cloudformation").create_stack(StackName=TEST_STACK_NAME)
        world["result"] = result
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc
