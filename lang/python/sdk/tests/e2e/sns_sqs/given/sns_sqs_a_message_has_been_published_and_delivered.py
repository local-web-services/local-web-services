"""
Given: a message has been published to an "SNS" topic and delivered to the subscribed "SQS" queue
"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsSqsTestClient
from ..constants import TEST_MESSAGE, _topic_arn


@given('a message has been published to an "SNS" topic and delivered to the subscribed "SQS" queue')
def sns_sqs_a_message_has_been_published_and_delivered(lws_session):
    SnsSqsTestClient(lws_session).create_topic()
    SnsSqsTestClient(lws_session).create_queue()
    SnsSqsTestClient(lws_session).subscribe_queue_to_topic()
    SnsSqsTestClient(lws_session)._sns.publish(TopicArn=_topic_arn(), Message=TEST_MESSAGE)
