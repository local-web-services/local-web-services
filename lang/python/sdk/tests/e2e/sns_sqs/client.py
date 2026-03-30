"""Test client for sns_sqs tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import TEST_QUEUE, TEST_TOPIC, _queue_arn, _topic_arn


class SnsSqsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _sns = lws_session.client("sns")
        self._sns = _sns
        _sqs = lws_session.client("sqs")
        self._sqs = _sqs

    def queue_url(self, name=TEST_QUEUE):
        return self._session.queue_url(name)

    def create_topic(self, name=TEST_TOPIC):
        try:
            self._sns.create_topic(Name=name)
        except ClientError as exc:
            if exc.response["Error"]["Code"] == "TopicAlreadyExists":
                return
            raise

    def create_queue(self, name=TEST_QUEUE):
        try:
            self._sqs.create_queue(QueueName=name)
        except ClientError as exc:
            if exc.response["Error"]["Code"] in (
                "QueueAlreadyExists",
                "AWS.SimpleQueueService.QueueAlreadyExists",
            ):
                return
            raise

    def subscribe_queue_to_topic(self):
        self._sns.subscribe(TopicArn=_topic_arn(), Protocol="sqs", Endpoint=_queue_arn())
