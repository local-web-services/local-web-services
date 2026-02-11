"""Integration test for SQS SendMessage."""

from __future__ import annotations

import httpx


class TestSendMessage:
    async def test_send_and_receive_message(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_message_body = "hello world"
        queue_url = "http://localhost:4566/000000000000/test-queue"
        expected_body_xml = f"<Body>{expected_message_body}</Body>"

        # Act - Send
        send_resp = await client.post(
            "/",
            data={
                "Action": "SendMessage",
                "QueueUrl": queue_url,
                "MessageBody": expected_message_body,
            },
        )

        # Assert - Send
        assert send_resp.status_code == expected_status_code
        assert "<MessageId>" in send_resp.text

        # Act - Receive
        recv_resp = await client.post(
            "/",
            data={
                "Action": "ReceiveMessage",
                "QueueUrl": queue_url,
                "MaxNumberOfMessages": "1",
            },
        )

        # Assert - Receive
        assert recv_resp.status_code == expected_status_code
        assert expected_body_xml in recv_resp.text
