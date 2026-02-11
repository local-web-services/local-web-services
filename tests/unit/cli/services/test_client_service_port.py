"""Unit tests for LwsClient.service_port."""

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


class TestServicePort:
    @pytest.mark.asyncio
    async def test_returns_port(self):
        # Arrange
        expected_port = 3002
        service_name = "sqs"
        client = LwsClient(port=3000)
        client._metadata = SAMPLE_METADATA

        # Act
        actual_port = await client.service_port(service_name)

        # Assert
        assert actual_port == expected_port

    @pytest.mark.asyncio
    async def test_raises_for_missing_service(self):
        # Arrange
        client = LwsClient(port=3000)
        client._metadata = SAMPLE_METADATA

        # Act / Assert
        with pytest.raises(DiscoveryError, match="not found"):
            await client.service_port("nonexistent")
