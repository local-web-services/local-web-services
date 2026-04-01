"""Tests for ServiceTaskBridge capacity enforcement on S3 dispatches."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeExhaustedCapacity, FakeS3, FakeUnlimitedCapacity


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestS3Capacity:
    """S3 dispatch is blocked when capacity is exhausted."""

    async def test_get_object_raises_when_capacity_exhausted(self) -> None:
        # Arrange
        s3 = FakeS3(buckets={"my-bucket"})
        s3._store["my-bucket/file.txt"] = b"content"
        bridge = make_bridge(s3=s3, s3_capacity=FakeExhaustedCapacity())
        expected_error = "S3 capacity is exhausted"

        # Act / Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke(
                "arn:aws:states:::s3:getObject",
                {"Bucket": "my-bucket", "Key": "file.txt"},
            )

    async def test_put_object_raises_when_capacity_exhausted(self) -> None:
        # Arrange
        s3 = FakeS3(buckets={"my-bucket"})
        bridge = make_bridge(s3=s3, s3_capacity=FakeExhaustedCapacity())
        expected_error = "S3 capacity is exhausted"

        # Act / Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke(
                "arn:aws:states:::s3:putObject",
                {"Bucket": "my-bucket", "Key": "out.txt", "Body": "data"},
            )

    async def test_put_object_succeeds_when_capacity_unlimited(self) -> None:
        # Arrange
        s3 = FakeS3(buckets={"my-bucket"})
        bridge = make_bridge(s3=s3, s3_capacity=FakeUnlimitedCapacity())

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::s3:putObject",
            {"Bucket": "my-bucket", "Key": "out.txt", "Body": "data"},
        )

        # Assert
        assert result == {}, f"Expected empty result dict but got {result!r}"
