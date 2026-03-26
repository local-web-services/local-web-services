"""Then: the queue is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import StepfunctionsSqsTestClient
from ..constants import TEST_QUEUE


@then('the queue is "ACTIVE"')
def queue_is_active_then(lws_session):
    url = StepfunctionsSqsTestClient(lws_session).queue_url()
    resp = StepfunctionsSqsTestClient(lws_session)._sqs.get_queue_attributes(
        QueueUrl=url, AttributeNames=["All"]
    )
    assert (
        resp.get("Attributes") is not None
    ), f"Expected queue '{TEST_QUEUE}' to be ACTIVE but got no attributes"
