"""When: an "operation" is added to an "aws fake" """

from __future__ import annotations

from pytest_bdd import when

from ..constants import (
    TEST_OPERATION,
    TEST_RESPONSE_BODY,
    TEST_RESPONSE_STATUS,
    TEST_SERVICE,
)


@when('an "operation" is added to an "aws fake"')
def add_operation_to_aws_fake(lws_session, world):
    try:
        world["result"] = lws_session.client("aws_fake").add_operation(
            TEST_SERVICE,
            TEST_OPERATION,
            status=TEST_RESPONSE_STATUS,
            body=TEST_RESPONSE_BODY,
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
