"""Test client for sqs tests."""

from __future__ import annotations

from .constants import QUEUE_URL, TEST_MESSAGE, TEST_QUEUE


class SqsTestClient:
    def __init__(self, client):
        self._client = client

    def create_queue(self, name: str = TEST_QUEUE) -> None:
        r = self._client.post("/", data={"Action": "CreateQueue", "QueueName": name})
        assert r.status_code == 200, f"Expected {200!r} but got {r.status_code!r}"

    def send_message(self, queue_url: str = QUEUE_URL) -> None:
        r = self._client.post(
            "/", data={"Action": "SendMessage", "QueueUrl": queue_url, "MessageBody": TEST_MESSAGE}
        )
        assert r.status_code == 200, f"Expected {200!r} but got {r.status_code!r}"

    def receive_message(self, queue_url: str = QUEUE_URL) -> dict | None:
        r = self._client.post(
            "/",
            data={
                "Action": "ReceiveMessage",
                "QueueUrl": queue_url,
                "MaxNumberOfMessages": "1",
                "VisibilityTimeout": "30",
                "WaitTimeSeconds": "0",
            },
        )
        if r.status_code != 200 or "<Message>" not in r.text:
            return None
        text = r.text
        start = text.index("<ReceiptHandle>") + len("<ReceiptHandle>")
        end = text.index("</ReceiptHandle>")
        receipt_handle = text[start:end]
        body_start = text.index("<Body>") + len("<Body>")
        body_end = text.index("</Body>")
        body = text[body_start:body_end]
        return {"ReceiptHandle": receipt_handle, "Body": body}
