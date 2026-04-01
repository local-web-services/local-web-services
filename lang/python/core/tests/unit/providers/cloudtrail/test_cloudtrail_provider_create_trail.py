"""Tests for CloudTrailProvider trail creation, duplicate detection, and capacity."""

from __future__ import annotations

import pytest

from lws.providers.cloudtrail.provider import CloudTrailProvider


class TestCloudTrailProviderCreateTrail:
    """Trail creation: success, duplicate name, capacity limit."""

    def test_create_trail_returns_trail_config(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        expected_name = "my-trail"
        expected_bucket = "my-bucket"

        # Act
        actual = provider.create_trail(expected_name, expected_bucket)

        # Assert
        assert actual.name == expected_name
        assert actual.s3_bucket == expected_bucket
        assert actual.logging is False

    def test_create_trail_is_retrievable(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        expected_name = "retrievable-trail"

        # Act
        provider.create_trail(expected_name, "bucket")
        actual = provider.get_trail(expected_name)

        # Assert
        assert actual.name == expected_name

    def test_create_trail_duplicate_raises(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        provider.create_trail("dup-trail", "bucket")

        # Act
        # Assert
        with pytest.raises(ValueError, match="TrailAlreadyExistsException"):
            provider.create_trail("dup-trail", "bucket")

    def test_create_trail_capacity_limit_raises(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        for i in range(5):
            provider.create_trail(f"trail-{i}", "bucket")

        # Act
        # Assert
        with pytest.raises(ValueError, match="MaximumNumberOfTrailsExceededException"):
            provider.create_trail("trail-overflow", "bucket")

    def test_create_trail_arn_format(self) -> None:
        # Arrange
        provider = CloudTrailProvider()

        # Act
        actual = provider.create_trail("arn-trail", "bucket")

        # Assert
        expected_prefix = "arn:aws:cloudtrail:us-east-1:000000000000:trail/"
        assert actual.arn.startswith(expected_prefix)

    def test_create_trail_after_delete_reuses_slot(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        for i in range(5):
            provider.create_trail(f"trail-{i}", "bucket")
        provider.delete_trail("trail-0")

        # Act — should succeed because a slot was freed
        actual = provider.create_trail("trail-new", "bucket")

        # Assert
        assert actual.name == "trail-new"
