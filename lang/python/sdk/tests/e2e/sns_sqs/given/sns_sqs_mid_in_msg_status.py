"""Given: mid in msg_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsSqsTestClient
from ..constants import TEST_MESSAGE


@given("mid in msg_status")
def sns_sqs_mid_in_msg_status(lws_session):
    SnsSqsTestClient(lws_session).create_queue()
    url = SnsSqsTestClient(lws_session).queue_url()
    SnsSqsTestClient(lws_session)._sqs.send_message(QueueUrl=url, MessageBody=TEST_MESSAGE)
