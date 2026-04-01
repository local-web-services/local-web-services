"""Given: an EventBridge rule matches on source aws.cloudtrail and detail.eventName CreateBucket"""

from __future__ import annotations

import json

from pytest_bdd import given

from ..constants import TEST_EB_BUS


@given("an EventBridge rule matches on source aws.cloudtrail and detail.eventName CreateBucket")
def an_eventbridge_rule_matches_on_source_aws_cloudtrail_and_detail_event_name_create_bucket(
    lws_session,
):
    events = lws_session.client("events")
    try:
        events.put_rule(
            Name="cloudtrail-createbucket-rule",
            EventPattern=json.dumps(
                {
                    "source": ["aws.cloudtrail"],
                    "detail": {"eventName": ["CreateBucket"]},
                }
            ),
            EventBusName=TEST_EB_BUS,
            State="ENABLED",
        )
    except Exception:
        pass
