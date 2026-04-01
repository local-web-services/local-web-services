"""When: a cloudformation stack is updated"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_STACK_NAME


@when("a cloudformation stack is updated")
def update_stack(lws_session, world):
    try:
        result = lws_session.client("cloudformation").update_stack(
            StackName=TEST_STACK_NAME, TemplateBody="{}"
        )
        world["result"] = result
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc
