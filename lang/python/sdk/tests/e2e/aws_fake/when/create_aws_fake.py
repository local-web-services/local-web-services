"""When: an "AWS" fake is created for a service"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SERVICE


@when('an "AWS" fake is created for a service')
def create_aws_fake(lws_session, world):
    try:
        world["result"] = lws_session.client("aws_fake").create(TEST_SERVICE)
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
