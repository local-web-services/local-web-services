"""Unit tests for LwsClient.service_port."""

from __future__ import annotations

import pytest

from ldk.cli.services.client import DiscoveryError, LwsClient

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
        client = LwsClient(port=3000)
        client._metadata = SAMPLE_METADATA
        port = await client.service_port("sqs")
        assert port == 3002

    @pytest.mark.asyncio
    async def test_raises_for_missing_service(self):
        client = LwsClient(port=3000)
        client._metadata = SAMPLE_METADATA
        with pytest.raises(DiscoveryError, match="not found"):
            await client.service_port("nonexistent")
