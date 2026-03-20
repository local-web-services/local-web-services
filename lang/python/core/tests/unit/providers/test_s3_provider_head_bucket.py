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
        # Arrange
        bucket_name = "my-bucket"
        await provider.create_bucket(bucket_name)

        # Act
        actual_meta = await provider.head_bucket(bucket_name)

        # Assert
        assert (
            actual_meta["BucketName"] == bucket_name
        ), f'Expected {bucket_name!r} but got {actual_meta["BucketName"]!r}'
        assert (
            "CreationDate" in actual_meta
        ), f'Expected {"CreationDate"!r} to be in {actual_meta!r}'

    @pytest.mark.asyncio
    async def test_head_nonexistent_raises(self, provider: S3Provider) -> None:
        with pytest.raises(KeyError, match="not found"):
            await provider.head_bucket("nonexistent")
