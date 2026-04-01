"""When: an "eventbridge" "rule" was "ENABLED" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUS, TEST_RULE


@when('an "eventbridge" "rule" was "ENABLED"')
def enable_rule(lws_session, world):
    try:
        resp = lws_session.client("events").enable_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
