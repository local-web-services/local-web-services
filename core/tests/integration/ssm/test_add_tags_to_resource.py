"""Integration test for SSM AddTagsToResource."""

from __future__ import annotations

import httpx


class TestAddTagsToResource:
    async def test_add_tags_to_resource(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        param_name = "/app/tag-target"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": param_name, "Value": "value"},
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.AddTagsToResource"},
            json={
                "ResourceType": "Parameter",
                "ResourceId": param_name,
                "Tags": [{"Key": "env", "Value": "test"}],
            },
        )

        # Assert
        assert response.status_code == expected_status_code
