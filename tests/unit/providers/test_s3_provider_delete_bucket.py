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


class TestDeleteBucket:
    @pytest.mark.asyncio
    async def test_delete_bucket(self, provider: S3Provider, tmp_path: Path) -> None:
        # Arrange
        bucket_name = "my-bucket"
        await provider.create_bucket(bucket_name)

        # Act
        await provider.delete_bucket(bucket_name)

        # Assert
        actual_buckets = await provider.list_buckets()
        assert bucket_name not in actual_buckets
        assert not (tmp_path / "s3" / bucket_name).exists()

    @pytest.mark.asyncio
    async def test_delete_nonexistent_raises(self, provider: S3Provider) -> None:
        with pytest.raises(KeyError, match="not found"):
            await provider.delete_bucket("nonexistent")
