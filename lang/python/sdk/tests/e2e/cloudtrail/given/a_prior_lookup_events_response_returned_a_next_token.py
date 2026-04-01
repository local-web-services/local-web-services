"""Given: a prior LookupEvents response returned a NextToken"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SQS_QUEUE


@given("a prior LookupEvents response returned a NextToken")
def a_prior_lookup_events_response_returned_a_next_token(lws_session, world):
    sqs = lws_session.client("sqs")
    for i in range(55):
        try:
            sqs.create_queue(QueueName=f"{TEST_SQS_QUEUE}-next-{i}")
        except Exception:
            pass
    ct = lws_session.client("cloudtrail")
    resp = ct.lookup_events(MaxResults=50)
    world["next_token"] = resp.get("NextToken")
