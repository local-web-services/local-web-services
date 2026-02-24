"""Integration test for SSM ListTagsForResource."""

from __future__ import annotations

import httpx


class TestListTagsForResource:
    async def test_list_tags_for_resource(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        param_name = "/app/list-tags-target"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": param_name, "Value": "value"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.ListTagsForResource"},
            json={
                "ResourceType": "Parameter",
                "ResourceId": param_name,
            },
        )

        # Assert
        assert response.status_code == expected_status_code
