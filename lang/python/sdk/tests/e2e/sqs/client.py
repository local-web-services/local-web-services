"""Test client for sqs tests."""

from __future__ import annotations

from botocore.exceptions import ClientError

from .constants import TEST_MESSAGE, TEST_QUEUE


class SqsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("sqs")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def queue_url(self, name=TEST_QUEUE):
        return self._session.queue_url(name)

    def create_queue(self, name=TEST_QUEUE):
        try:
            self._client.create_queue(QueueName=name)
        except ClientError as exc:
            if exc.response["Error"]["Code"] in (
                "QueueAlreadyExists",
                "AWS.SimpleQueueService.QueueAlreadyExists",
            ):
                return
            raise

    def send_message(self, name=TEST_QUEUE):
        client = self._client
        return client.send_message(QueueUrl=self.queue_url(name), MessageBody=TEST_MESSAGE)

    def receive_message(self, name=TEST_QUEUE):
        client = self._client
        resp = client.receive_message(
            QueueUrl=self.queue_url(name),
            MaxNumberOfMessages=1,
            VisibilityTimeout=30,
            WaitTimeSeconds=0,
        )
        msgs = resp.get("Messages", [])
        return msgs[0] if msgs else None
