"""Tests for S3 provider bucket management operations."""

from __future__ import annotations

from pathlib import Path

import pytest

from lws.providers.s3.provider import S3Provider


@pytest.fixture
async def provider(tmp_path: Path):
    """Provider started with no buckets."""
    p = S3Provider(data_dir=tmp_path)
    await p.start()
    yield p
    await p.stop()


class TestListBuckets:
    @pytest.mark.asyncio
    async def test_list_buckets_empty(self, provider: S3Provider) -> None:
        buckets = await provider.list_buckets()
        assert buckets == []

    @pytest.mark.asyncio
    async def test_list_buckets_sorted(self, provider: S3Provider) -> None:
        await provider.create_bucket("zebra")
        await provider.create_bucket("alpha")
        await provider.create_bucket("middle")

        buckets = await provider.list_buckets()
        assert buckets == ["alpha", "middle", "zebra"]
