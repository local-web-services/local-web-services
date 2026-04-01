"""Given: an "AVAILABLE" message existed in the queue"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSqsTestClient
from ..constants import TEST_MESSAGE


@given('an "AVAILABLE" message existed in the queue')
def available_message_exists_in_queue(lws_session):
    EventsSqsTestClient(lws_session).create_queue()
    EventsSqsTestClient(lws_session)._sqs.send_message(
        QueueUrl=EventsSqsTestClient(lws_session).queue_url(), MessageBody=TEST_MESSAGE
    )
