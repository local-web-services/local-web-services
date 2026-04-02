"""When: an "eventbridge" "bus" is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUS


@when('an "eventbridge" "bus" is created')
def create_event_bus(lws_session, world):
    try:
        world["result"] = lws_session.client("events").create_event_bus(Name=TEST_BUS)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
