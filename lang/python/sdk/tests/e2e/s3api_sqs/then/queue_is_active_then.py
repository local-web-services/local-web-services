"""Then: the "sqs" "queue" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import S3apiSqsTestClient
from ..constants import TEST_QUEUE


@then('the "sqs" "queue" will be "ACTIVE"')
def queue_is_active_then(lws_session):
    url = S3apiSqsTestClient(lws_session).queue_url()
    resp = lws_session.client("sqs").get_queue_attributes(QueueUrl=url, AttributeNames=["All"])
    assert (
        resp.get("Attributes") is not None
    ), f"Expected queue '{TEST_QUEUE}' to be ACTIVE but got no attributes"
