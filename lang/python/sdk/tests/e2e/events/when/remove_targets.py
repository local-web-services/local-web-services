"""When: targets are removed from an "eventbridge" "rule" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUS, TEST_RULE, TEST_TARGET_ID


@when('targets are removed from an "eventbridge" "rule"')
def remove_targets(lws_session, world):
    try:
        resp = lws_session.client("events").remove_targets(
            Rule=TEST_RULE, EventBusName=TEST_BUS, Ids=[TEST_TARGET_ID]
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
