"""Unit tests for LwsClient discovery."""

from __future__ import annotations

from unittest.mock import AsyncMock, patch

import httpx
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


class TestDiscovery:
    @pytest.mark.asyncio
    async def test_discover_returns_metadata(self):
        client = LwsClient(port=3000)

        mock_resp = httpx.Response(
            200,
            json=SAMPLE_METADATA,
            request=httpx.Request("GET", "http://localhost:3000/_ldk/resources"),
        )

        with patch("httpx.AsyncClient") as mock_cls:
            instance = AsyncMock()
            instance.get.return_value = mock_resp
            instance.__aenter__ = AsyncMock(return_value=instance)
            instance.__aexit__ = AsyncMock(return_value=False)
            mock_cls.return_value = instance

            result = await client.discover()
            assert result["port"] == 3000
            assert "sqs" in result["services"]

    @pytest.mark.asyncio
    async def test_discover_caches_result(self):
        client = LwsClient(port=3000)
        client._metadata = SAMPLE_METADATA
        result = await client.discover()
        assert result is SAMPLE_METADATA

    @pytest.mark.asyncio
    async def test_discover_raises_on_failure(self):
        client = LwsClient(port=9999)
        with patch("httpx.AsyncClient") as mock_cls:
            instance = AsyncMock()
            instance.get.side_effect = Exception("connection refused")
            instance.__aenter__ = AsyncMock(return_value=instance)
            instance.__aexit__ = AsyncMock(return_value=False)
            mock_cls.return_value = instance

            with pytest.raises(DiscoveryError, match="Cannot reach"):
                await client.discover()
