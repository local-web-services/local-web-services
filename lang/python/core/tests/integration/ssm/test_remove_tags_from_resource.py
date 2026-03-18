"""Integration test for SSM RemoveTagsFromResource."""

from __future__ import annotations

import httpx


class TestRemoveTagsFromResource:
    async def test_remove_tags_from_resource(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        param_name = "/app/untag-target"

        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.PutParameter"},
            json={"Name": param_name, "Value": "value"},
        )
        await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.AddTagsToResource"},
            json={
                "ResourceType": "Parameter",
                "ResourceId": param_name,
                "Tags": [{"Key": "env", "Value": "test"}],
            },
        )

        # Act
        response = await client.post(
            "/",
            headers={"X-Amz-Target": "AmazonSSM.RemoveTagsFromResource"},
            json={
                "ResourceType": "Parameter",
                "ResourceId": param_name,
                "TagKeys": ["env"],
            },
        )

        # Assert
        assert response.status_code == expected_status_code
