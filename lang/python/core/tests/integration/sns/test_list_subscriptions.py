"""Integration test for SNS ListSubscriptions."""

from __future__ import annotations

import httpx


class TestListSubscriptions:
    async def test_list_subscriptions(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200

        # Act
        resp = await client.post(
            "/",
            data={"Action": "ListSubscriptions"},
        )

        # Assert
        assert resp.status_code == expected_status_code
        assert "<ListSubscriptionsResponse>" in resp.text
