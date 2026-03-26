"""When: an EventBridge rule is described"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import EventsTestClient
from ..constants import TEST_BUS, TEST_RULE


@when("an EventBridge rule is described")
def describe_rule(lws_session, world):
    try:
        resp = EventsTestClient(lws_session).describe_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
