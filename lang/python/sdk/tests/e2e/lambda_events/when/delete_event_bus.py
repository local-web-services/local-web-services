"""When: the "eventbridge" "bus" is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUS


@when('the "eventbridge" "bus" is deleted')
def delete_event_bus(lws_session, world):
    try:
        lws_session.client("events").delete_event_bus(Name=TEST_BUS)
        world["result"] = {"EventBusName": TEST_BUS}
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
