"""Tests for ServiceTaskBridge S3 bucket existence pre-flight validation."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeS3


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestServiceTaskBridgeS3TargetValidation:
    """S3 getObject/putObject pre-flight bucket existence checks."""

    async def test_put_object_succeeds_when_bucket_exists(self) -> None:
        # Arrange
        expected_bucket = "my-bucket"
        s3 = FakeS3(buckets={expected_bucket})
        bridge = make_bridge(s3=s3)

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::s3:putObject",
            {"Bucket": expected_bucket, "Key": "key.txt", "Body": "data"},
        )

        # Assert
        actual_result = result
        assert actual_result == {}, f"Expected empty result but got {actual_result!r}"

    async def test_put_object_raises_when_bucket_does_not_exist(self) -> None:
        # Arrange
        expected_error_pattern = "S3 bucket does not exist"
        s3 = FakeS3(buckets=set())  # no buckets
        bridge = make_bridge(s3=s3)

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error_pattern):
            await bridge.invoke(
                "arn:aws:states:::s3:putObject",
                {"Bucket": "nonexistent-bucket", "Key": "key.txt", "Body": "data"},
            )

    async def test_get_object_succeeds_when_bucket_and_object_exist(self) -> None:
        # Arrange
        expected_bucket = "my-bucket"
        expected_key = "my-key.txt"
        expected_body = b"file contents"
        s3 = FakeS3(buckets={expected_bucket})
        s3._store[f"{expected_bucket}/{expected_key}"] = expected_body
        bridge = make_bridge(s3=s3)

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::s3:getObject",
            {"Bucket": expected_bucket, "Key": expected_key},
        )

        # Assert
        actual_body = result["Body"]
        expected_body_str = expected_body.decode("utf-8")
        assert (
            actual_body == expected_body_str
        ), f"Expected body '{expected_body_str}' but got '{actual_body}'"

    async def test_get_object_raises_when_bucket_does_not_exist(self) -> None:
        # Arrange
        expected_error_pattern = "S3 bucket does not exist"
        s3 = FakeS3(buckets=set())
        bridge = make_bridge(s3=s3)

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error_pattern):
            await bridge.invoke(
                "arn:aws:states:::s3:getObject",
                {"Bucket": "ghost-bucket", "Key": "key.txt"},
            )

    async def test_put_object_raises_correct_bucket_name_in_error(self) -> None:
        # Arrange
        expected_missing_bucket = "missing-bucket"
        expected_error_pattern = expected_missing_bucket
        s3 = FakeS3(buckets=set())
        bridge = make_bridge(s3=s3)

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error_pattern):
            await bridge.invoke(
                "arn:aws:states:::s3:putObject",
                {"Bucket": expected_missing_bucket, "Key": "k", "Body": "v"},
            )
