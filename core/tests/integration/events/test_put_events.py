"""Integration test for EventBridge PutEvents."""

from __future__ import annotations

import json

import httpx


class TestPutEvents:
    async def test_put_events(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_failed_entry_count = 0
        expected_entry_count = 1

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.PutEvents"},
            json={
                "Entries": [
                    {
                        "Source": "my.app",
                        "DetailType": "OrderCreated",
                        "Detail": json.dumps({"orderId": "123"}),
                        "EventBusName": "default",
                    }
                ]
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        actual_failed_entry_count = body["FailedEntryCount"]
        actual_entry_count = len(body["Entries"])
        assert actual_failed_entry_count == expected_failed_entry_count
        assert actual_entry_count == expected_entry_count
        assert body["Entries"][0]["EventId"] is not None
