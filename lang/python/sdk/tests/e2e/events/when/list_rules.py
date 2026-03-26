"""When: all rules on an event bus are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import EventsTestClient
from ..constants import TEST_BUS


@when("all rules on an event bus are listed")
def list_rules(lws_session, world):
    try:
        resp = EventsTestClient(lws_session).list_rules(EventBusName=TEST_BUS)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
