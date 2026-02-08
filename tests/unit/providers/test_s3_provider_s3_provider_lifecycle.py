"""Tests for S3 provider (P1-12 through P1-16)."""

from __future__ import annotations

from pathlib import Path

import pytest

from ldk.providers.s3.provider import S3Provider
from ldk.providers.s3.storage import LocalBucketStorage

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


class TestS3ProviderLifecycle:
    """Provider lifecycle tests."""

    async def test_name(self, provider: S3Provider) -> None:
        assert provider.name == "s3"

    async def test_health_check_running(self, provider: S3Provider) -> None:
        assert await provider.health_check() is True

    async def test_health_check_stopped(self, tmp_path: Path) -> None:
        p = S3Provider(data_dir=tmp_path, buckets=["bucket"])
        assert await p.health_check() is False

    async def test_start_creates_bucket_dirs(self, tmp_path: Path) -> None:
        p = S3Provider(data_dir=tmp_path, buckets=["alpha", "beta"])
        await p.start()
        assert (tmp_path / "s3" / "alpha").is_dir()
        assert (tmp_path / "s3" / "beta").is_dir()
        await p.stop()

    async def test_stop_marks_unhealthy(self, tmp_path: Path) -> None:
        p = S3Provider(data_dir=tmp_path, buckets=["bucket"])
        await p.start()
        assert await p.health_check() is True
        await p.stop()
        assert await p.health_check() is False
