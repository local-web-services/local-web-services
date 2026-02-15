"""Integration test for Lambda DeleteEventSourceMapping."""

from __future__ import annotations

import httpx


class TestDeleteEventSourceMapping:
    async def test_delete_nonexistent_event_source_mapping(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 404
        expected_uuid = "nonexistent-uuid"

        # Act
        resp = await client.delete(
            f"/2015-03-31/event-source-mappings/{expected_uuid}",
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
