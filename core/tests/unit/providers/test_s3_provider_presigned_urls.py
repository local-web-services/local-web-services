"""Tests for S3 provider (P1-12 through P1-16)."""

from __future__ import annotations

from pathlib import Path

import pytest

from lws.providers.s3.presigned import generate_presigned_url, validate_presigned_url
from lws.providers.s3.provider import S3Provider
from lws.providers.s3.storage import LocalBucketStorage

# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------


@pytest.fixture
async def storage(tmp_path: Path) -> LocalBucketStorage:
    """Create a LocalBucketStorage instance."""
    return LocalBucketStorage(tmp_path)


@pytest.fixture
async def provider(tmp_path: Path) -> S3Provider:
    """Create, start, yield, and stop an S3Provider."""
    p = S3Provider(data_dir=tmp_path, buckets=["test-bucket", "other-bucket"])
    await p.start()
    yield p
    await p.stop()


# ---------------------------------------------------------------------------
# P1-12: LocalBucketStorage
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P1-14: S3Provider lifecycle and IObjectStore
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P1-15: NotificationDispatcher
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P1-16: Presigned URLs
# ---------------------------------------------------------------------------


class TestPresignedUrls:
    """Presigned URL generation and validation."""

    def test_generate_returns_url(self) -> None:
        url = generate_presigned_url("mybucket", "mykey")
        assert "mybucket" in url
        assert "mykey" in url
        assert "X-Amz-Signature" in url

    def test_validate_valid_url(self) -> None:
        key = "test-signing-key"
        url = generate_presigned_url("mybucket", "mykey", signing_key=key)
        assert validate_presigned_url(url, signing_key=key) is True

    def test_validate_wrong_key_fails(self) -> None:
        url = generate_presigned_url("mybucket", "mykey", signing_key="correct-key")
        assert validate_presigned_url(url, signing_key="wrong-key") is False

    def test_validate_expired_url(self) -> None:
        url = generate_presigned_url("mybucket", "mykey", expires_in=-1, signing_key="key")
        assert validate_presigned_url(url, signing_key="key") is False

    def test_validate_tampered_url(self) -> None:
        key = "signing-key"
        url = generate_presigned_url("mybucket", "mykey", signing_key=key)
        # Tamper with the signature
        tampered = url.replace("X-Amz-Signature=", "X-Amz-Signature=bad")
        assert validate_presigned_url(tampered, signing_key=key) is False

    def test_default_signing_key(self) -> None:
        """Using default key for both generate and validate should work."""
        url = generate_presigned_url("mybucket", "mykey")
        assert validate_presigned_url(url) is True

    def test_put_method(self) -> None:
        key = "test-key"
        url = generate_presigned_url("mybucket", "mykey", method="PUT", signing_key=key)
        assert "X-Amz-Method=PUT" in url
        assert validate_presigned_url(url, signing_key=key) is True

    def test_custom_base_url(self) -> None:
        url = generate_presigned_url("mybucket", "mykey", base_url="http://localhost:9000")
        assert url.startswith("http://localhost:9000/")
