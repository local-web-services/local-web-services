"""When: an "operation" is removed from an "aws fake" """

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_OPERATION, TEST_SERVICE


@when('an "operation" is removed from an "aws fake"')
def remove_operation_from_aws_fake(lws_session, world):
    try:
        lws_session.client("aws_fake").remove_operation(TEST_SERVICE, TEST_OPERATION)
        world["result"] = {"removed": TEST_OPERATION}
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
