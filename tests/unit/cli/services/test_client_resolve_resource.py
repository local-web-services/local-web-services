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
        client = LwsClient(port=3000)
        client._metadata = SAMPLE_METADATA
        resource = await client.resolve_resource("sqs", "MyQueue")
        assert resource["queue_url"] == "http://localhost:3002/000000000000/MyQueue"

    @pytest.mark.asyncio
    async def test_raises_for_missing_resource(self):
        client = LwsClient(port=3000)
        client._metadata = SAMPLE_METADATA
        with pytest.raises(DiscoveryError, match="not found"):
            await client.resolve_resource("sqs", "NonExistent")
