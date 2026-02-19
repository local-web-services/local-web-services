"""Tests for S3 bucket deletion cleaning up website configuration."""

from __future__ import annotations

from pathlib import Path

import pytest

from lws.providers.s3.provider import S3Provider


@pytest.fixture
async def provider(tmp_path: Path):
    """Provider started with one bucket."""
    p = S3Provider(data_dir=tmp_path, buckets=["test-bucket"])
    await p.start()
    yield p
    await p.stop()


class TestDeleteBucketCleansWebsite:
    @pytest.mark.asyncio
    async def test_delete_bucket_removes_website_config(self, provider: S3Provider) -> None:
        # Arrange
        bucket_name = "test-bucket"
        provider.put_bucket_website(bucket_name, {"index_document": "index.html"})

        # Act
        await provider.delete_bucket(bucket_name)

        # Assert — re-create bucket and verify config is gone
        await provider.create_bucket(bucket_name)
        actual_config = provider.get_bucket_website(bucket_name)
        assert actual_config is None
