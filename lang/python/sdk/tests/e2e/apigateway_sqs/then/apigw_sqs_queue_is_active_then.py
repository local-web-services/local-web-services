"""Then: the queue is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_QUEUE


@then('the queue is "ACTIVE"')
def apigw_sqs_queue_is_active_then(lws_session):
    resp = lws_session.client("sqs").list_queues(QueueNamePrefix=TEST_QUEUE)
    actual_urls = resp.get("QueueUrls", [])
    expected_count = 1
    actual_count = len(actual_urls)
    assert (
        actual_count >= expected_count
    ), f"Expected at least {expected_count} queue but found: {actual_count}"
