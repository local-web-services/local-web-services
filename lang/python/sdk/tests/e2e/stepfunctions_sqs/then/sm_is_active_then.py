"""Then: the "sqs" "queue" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_QUEUE


@then('the "sqs" "queue" will be "ACTIVE"')
def sm_is_active_then(lws_session):
    resp = lws_session.client("sqs").list_queues(QueueNamePrefix=TEST_QUEUE)
    queue_urls = resp.get("QueueUrls", [])
    assert any(
        TEST_QUEUE in url for url in queue_urls
    ), f"Expected SQS queue '{TEST_QUEUE}' to exist but found: {queue_urls}"
