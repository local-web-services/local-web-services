"""Tests for S3 provider delete_bucket_website."""

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


class TestDeleteBucketWebsite:
    @pytest.mark.asyncio
    async def test_delete_bucket_website(self, provider: S3Provider) -> None:
        # Arrange
        bucket_name = "test-bucket"
        provider.put_bucket_website(bucket_name, {"index_document": "index.html"})

        # Act
        provider.delete_bucket_website(bucket_name)

        # Assert
        actual_config = provider.get_bucket_website(bucket_name)
        assert actual_config is None

    @pytest.mark.asyncio
    async def test_delete_bucket_website_not_configured(self, provider: S3Provider) -> None:
        # Arrange
        bucket_name = "test-bucket"

        # Act (should not raise)
        provider.delete_bucket_website(bucket_name)

        # Assert
        actual_config = provider.get_bucket_website(bucket_name)
        assert actual_config is None

    @pytest.mark.asyncio
    async def test_delete_bucket_website_nonexistent_bucket_raises(
        self, provider: S3Provider
    ) -> None:
        # Arrange
        bucket_name = "nonexistent"

        # Act
        # Assert
        with pytest.raises(KeyError, match="Bucket not found"):
            provider.delete_bucket_website(bucket_name)
