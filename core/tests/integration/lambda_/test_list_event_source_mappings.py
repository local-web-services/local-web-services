"""Integration test for Lambda ListEventSourceMappings."""

from __future__ import annotations

import httpx


class TestListEventSourceMappings:
    async def test_list_event_source_mappings(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200

        # Act
        resp = await client.get("/2015-03-31/event-source-mappings")

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
