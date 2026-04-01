"""Test client for lambda_sqs tests."""

from __future__ import annotations

from .constants import ROLE_ARN, TEST_DLQ, TEST_FUNC, TEST_QUEUE


class LambdaSqsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _lambda = lws_session.client("lambda")
        self._lambda = _lambda
        _sqs = lws_session.client("sqs")
        self._sqs = _sqs

    def queue_url(self, name=TEST_QUEUE):
        return self._session.queue_url(name)

    def dlq_url(self, name=TEST_DLQ):
        return self._session.queue_url(name)

    def create_function(self, name=TEST_FUNC):
        try:
            self._lambda.create_function(
                FunctionName=name,
                Runtime="python3.12",
                Role=ROLE_ARN,
                Handler="index.handler",
                Code={"ZipFile": b"fake"},
            )
        except Exception:
            pass

    def create_queue(self, name=TEST_QUEUE):
        try:
            self._sqs.create_queue(QueueName=name)
        except Exception:
            pass

    def create_dlq(self, name=TEST_DLQ):
        try:
            self._sqs.create_queue(QueueName=name)
        except Exception:
            pass
