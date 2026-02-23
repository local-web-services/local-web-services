"""Tests for S3 multipart upload operations."""

from __future__ import annotations

from pathlib import Path

import pytest

from lws.providers.s3.provider import S3Provider


@pytest.fixture
async def provider(tmp_path: Path):
    p = S3Provider(data_dir=tmp_path, buckets=["test-bucket"])
    await p.start()
    yield p
    await p.stop()


class TestMultipartUpload:
    @pytest.mark.asyncio
    async def test_create_upload_parts_complete_merges_object(self, provider: S3Provider) -> None:
        # Arrange
        bucket = "test-bucket"
        key = "large-file.bin"
        part1 = b"hello "
        part2 = b"world"
        expected_body = b"hello world"

        # Act
        upload_id = provider.create_multipart_upload(bucket, key)
        provider.upload_part(bucket, key, upload_id, 1, part1)
        provider.upload_part(bucket, key, upload_id, 2, part2)
        result = await provider.complete_multipart_upload(bucket, key, upload_id)

        # Assert
        actual_body = await provider.get_object(bucket, key)
        assert actual_body == expected_body
        expected_key = key
        actual_key = result["Key"]
        assert actual_key == expected_key
        expected_bucket = bucket
        actual_bucket = result["Bucket"]
        assert actual_bucket == expected_bucket

    @pytest.mark.asyncio
    async def test_abort_removes_upload(self, provider: S3Provider) -> None:
        # Arrange
        bucket = "test-bucket"
        key = "aborted.bin"
        upload_id = provider.create_multipart_upload(bucket, key)
        provider.upload_part(bucket, key, upload_id, 1, b"data")

        # Act
        provider.abort_multipart_upload(upload_id)

        # Assert
        with pytest.raises(KeyError):
            provider.list_parts(upload_id)

    @pytest.mark.asyncio
    async def test_list_parts_returns_correct_info(self, provider: S3Provider) -> None:
        # Arrange
        bucket = "test-bucket"
        key = "parts.bin"
        part_data = b"abcdef"
        upload_id = provider.create_multipart_upload(bucket, key)
        provider.upload_part(bucket, key, upload_id, 1, part_data)

        # Act
        parts = provider.list_parts(upload_id)

        # Assert
        assert len(parts) == 1
        expected_part_number = 1
        actual_part_number = parts[0]["PartNumber"]
        assert actual_part_number == expected_part_number
        expected_size = len(part_data)
        actual_size = parts[0]["Size"]
        assert actual_size == expected_size

    @pytest.mark.asyncio
    async def test_complete_with_unknown_upload_id_raises(self, provider: S3Provider) -> None:
        # Arrange
        bucket = "test-bucket"
        key = "missing.bin"
        bad_upload_id = "nonexistent-id"

        # Act / Assert
        with pytest.raises(KeyError):
            await provider.complete_multipart_upload(bucket, key, bad_upload_id)
