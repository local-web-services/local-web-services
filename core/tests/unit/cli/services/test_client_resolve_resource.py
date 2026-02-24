"""Unit tests for LwsClient.resolve_resource."""

from __future__ import annotations

import pytest

from lws.cli.services.client import DiscoveryError, LwsClient

SAMPLE_METADATA = {
    "port": 3000,
    "services": {
        "sqs": {
            "port": 3002,
            "resources": [
                {
                    "name": "MyQueue",
                    "queue_url": "http://localhost:3002/000000000000/MyQueue",
                }
            ],
        },
    },
}


class TestResolveResource:
    @pytest.mark.asyncio
    async def test_resolves_by_name(self):
        # Arrange
        expected_queue_url = "http://localhost:3002/000000000000/MyQueue"
        service_name = "sqs"
        resource_name = "MyQueue"
        client = LwsClient(port=3000)
        client._metadata = SAMPLE_METADATA

        # Act
        resource = await client.resolve_resource(service_name, resource_name)
        actual_queue_url = resource["queue_url"]

        # Assert
        assert actual_queue_url == expected_queue_url

    @pytest.mark.asyncio
    async def test_raises_for_missing_resource(self):
        # Arrange
        client = LwsClient(port=3000)
        client._metadata = SAMPLE_METADATA

        # Act / Assert
        with pytest.raises(DiscoveryError, match="not found"):
            await client.resolve_resource("sqs", "NonExistent")
