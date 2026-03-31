"""Then: the request will be "ACCEPTED" and the "sqs" "message" will be "AVAILABLE" in the "sqs" "queue" """

from __future__ import annotations

from pytest_bdd import then

from ..client import ApigatewaySqsTestClient
from ..constants import TEST_QUEUE


@then(
    'the request will be "ACCEPTED" and the "sqs" "message" will be "AVAILABLE" in the "sqs" "queue"'
)
def request_accepted_message_available(lws_session, world):
    expected_status = 200
    actual_status = world.get("invoke_status")
    assert (
        actual_status == expected_status
    ), f"Expected request status {expected_status!r} but got {actual_status!r}"
    q_url = ApigatewaySqsTestClient(lws_session).queue_url(TEST_QUEUE)
    recv_resp = lws_session.client("sqs").receive_message(QueueUrl=q_url, MaxNumberOfMessages=1)
    actual_messages = recv_resp.get("Messages", [])
    expected_count = 1
    actual_count = len(actual_messages)
    assert (
        actual_count >= expected_count
    ), f"Expected at least {expected_count} message in queue but found {actual_count}"
