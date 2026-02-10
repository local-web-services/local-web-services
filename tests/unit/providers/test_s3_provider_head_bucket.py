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


class TestHeadBucket:
    @pytest.mark.asyncio
    async def test_head_bucket(self, provider: S3Provider) -> None:
        await provider.create_bucket("my-bucket")
        meta = await provider.head_bucket("my-bucket")

        assert meta["BucketName"] == "my-bucket"
        assert "CreationDate" in meta

    @pytest.mark.asyncio
    async def test_head_nonexistent_raises(self, provider: S3Provider) -> None:
        with pytest.raises(KeyError, match="not found"):
            await provider.head_bucket("nonexistent")
