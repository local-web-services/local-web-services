"""Then: the "sqs" "queue" will be "DELETED" and its messages will be removed"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_QUEUE


@then('the "sqs" "queue" will be "DELETED" and its messages will be removed')
def queue_is_deleted_then(lws_session):
    client = lws_session.client("sqs")
    resp = client.list_queues(QueueNamePrefix=TEST_QUEUE)
    actual_urls = resp.get("QueueUrls", [])
    assert not any(
        TEST_QUEUE in u for u in actual_urls
    ), f"Expected queue '{TEST_QUEUE}' to be deleted but found: {actual_urls}"
