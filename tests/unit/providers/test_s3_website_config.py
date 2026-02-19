"""Tests for S3 provider put_bucket_website."""

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


class TestPutBucketWebsite:
    @pytest.mark.asyncio
    async def test_put_bucket_website(self, provider: S3Provider) -> None:
        # Arrange
        bucket_name = "test-bucket"
        expected_config = {"index_document": "index.html", "error_document": "404.html"}

        # Act
        provider.put_bucket_website(bucket_name, expected_config)

        # Assert
        actual_config = provider.get_bucket_website(bucket_name)
        assert actual_config == expected_config

    @pytest.mark.asyncio
    async def test_put_bucket_website_index_only(self, provider: S3Provider) -> None:
        # Arrange
        bucket_name = "test-bucket"
        expected_config = {"index_document": "index.html"}

        # Act
        provider.put_bucket_website(bucket_name, expected_config)

        # Assert
        actual_config = provider.get_bucket_website(bucket_name)
        assert actual_config == expected_config

    @pytest.mark.asyncio
    async def test_put_bucket_website_replaces_existing(self, provider: S3Provider) -> None:
        # Arrange
        bucket_name = "test-bucket"
        provider.put_bucket_website(bucket_name, {"index_document": "old.html"})
        expected_config = {"index_document": "new.html"}

        # Act
        provider.put_bucket_website(bucket_name, expected_config)

        # Assert
        actual_config = provider.get_bucket_website(bucket_name)
        assert actual_config == expected_config

    @pytest.mark.asyncio
    async def test_put_bucket_website_nonexistent_bucket_raises(self, provider: S3Provider) -> None:
        # Arrange
        bucket_name = "nonexistent"

        # Act
        # Assert
        with pytest.raises(KeyError, match="Bucket not found"):
            provider.put_bucket_website(bucket_name, {"index_document": "index.html"})
