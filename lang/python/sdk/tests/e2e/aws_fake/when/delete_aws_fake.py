"""When: an "AWS" fake is deleted"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SERVICE


@when('an "AWS" fake is deleted')
def delete_aws_fake(lws_session, world):
    try:
        lws_session.client("aws_fake").delete(TEST_SERVICE)
        world["result"] = {"deleted": TEST_SERVICE}
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
