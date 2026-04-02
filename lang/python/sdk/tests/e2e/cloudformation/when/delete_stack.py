"""When: a cloudformation stack is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_STACK_NAME


@when("a cloudformation stack is deleted")
@when('a "cloudformation" "stack" is deleted')
def delete_stack(lws_session, world):
    if world.get("stack_exists") is False:
        world["result"] = None
        world["error"] = ValueError("Guard: stack does not exist")
        return
    try:
        result = lws_session.client("cloudformation").delete_stack(StackName=TEST_STACK_NAME)
        world["result"] = result
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc
