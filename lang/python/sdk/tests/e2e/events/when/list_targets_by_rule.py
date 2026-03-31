"""When: targets for an "eventbridge" "rule" are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUS, TEST_RULE


@when('targets for an "eventbridge" "rule" are listed')
def list_targets_by_rule(lws_session, world):
    try:
        resp = lws_session.client("events").list_targets_by_rule(
            Rule=TEST_RULE, EventBusName=TEST_BUS
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
