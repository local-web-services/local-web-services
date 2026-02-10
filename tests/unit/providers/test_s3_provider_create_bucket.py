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


class TestCreateBucket:
    @pytest.mark.asyncio
    async def test_create_bucket(self, provider: S3Provider, tmp_path: Path) -> None:
        await provider.create_bucket("my-bucket")

        buckets = await provider.list_buckets()
        assert "my-bucket" in buckets

        # Directory should exist
        assert (tmp_path / "s3" / "my-bucket").is_dir()

    @pytest.mark.asyncio
    async def test_create_bucket_duplicate_raises(self, provider: S3Provider) -> None:
        await provider.create_bucket("my-bucket")

        with pytest.raises(ValueError, match="already exists"):
            await provider.create_bucket("my-bucket")
