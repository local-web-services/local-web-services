"""Tests for ServiceTaskBridge S3 service integration dispatch."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeS3


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestServiceTaskBridgeInvokeS3:
    """S3 service integration dispatching."""

    async def test_get_object_returns_body_string(self) -> None:
        # Arrange
        expected_body = "file content here"
        s3 = FakeS3()
        s3._store["my-bucket/data/file.txt"] = expected_body.encode("utf-8")
        bridge = make_bridge(s3=s3)

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::s3:getObject",
            {"Bucket": "my-bucket", "Key": "data/file.txt"},
        )

        # Assert
        actual_body = result["Body"]
        assert actual_body == expected_body

    async def test_get_object_not_found_raises(self) -> None:
        # Arrange
        s3 = FakeS3()
        bridge = make_bridge(s3=s3)
        expected_error = "S3 object not found"

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke(
                "arn:aws:states:::s3:getObject",
                {"Bucket": "bucket", "Key": "missing.txt"},
            )

    async def test_put_object_stores_string_as_bytes(self) -> None:
        # Arrange
        expected_key = "output/result.json"
        expected_content = '{"status": "ok"}'
        s3 = FakeS3()
        bridge = make_bridge(s3=s3)

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::s3:putObject",
            {"Bucket": "my-bucket", "Key": expected_key, "Body": expected_content},
        )

        # Assert
        actual_stored = s3._store[f"my-bucket/{expected_key}"]
        assert result == {}
        assert actual_stored == expected_content.encode("utf-8")

    async def test_get_object_missing_provider_raises(self) -> None:
        # Arrange
        bridge = make_bridge()
        expected_error = "No S3 provider"

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke("arn:aws:states:::s3:getObject", {})

    async def test_put_object_missing_provider_raises(self) -> None:
        # Arrange
        bridge = make_bridge()
        expected_error = "No S3 provider"

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke("arn:aws:states:::s3:putObject", {})
