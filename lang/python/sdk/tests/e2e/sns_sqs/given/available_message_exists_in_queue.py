"""Given: an "AVAILABLE" message exists in the queue"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsSqsTestClient
from ..constants import TEST_MESSAGE


@given('an "AVAILABLE" message exists in the queue')
def available_message_exists_in_queue(lws_session):
    SnsSqsTestClient(lws_session).create_queue()
    url = SnsSqsTestClient(lws_session).queue_url()
    SnsSqsTestClient(lws_session)._sqs.send_message(QueueUrl=url, MessageBody=TEST_MESSAGE)
