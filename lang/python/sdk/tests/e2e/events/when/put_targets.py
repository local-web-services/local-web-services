"""When: targets are added to a rule"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import EventsTestClient
from ..constants import TEST_BUS, TEST_RULE, TEST_TARGET_ARN, TEST_TARGET_ID


@when("targets are added to a rule")
def put_targets(lws_session, world):
    try:
        resp = EventsTestClient(lws_session).put_targets(
            Rule=TEST_RULE,
            EventBusName=TEST_BUS,
            Targets=[{"Id": TEST_TARGET_ID, "Arn": TEST_TARGET_ARN}],
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
