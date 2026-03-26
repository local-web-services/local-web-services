"""When: a rule is enabled"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import EventsTestClient
from ..constants import TEST_BUS, TEST_RULE


@when("a rule is enabled")
def enable_rule(lws_session, world):
    try:
        resp = EventsTestClient(lws_session).enable_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
