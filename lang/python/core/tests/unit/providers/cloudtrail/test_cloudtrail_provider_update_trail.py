"""Tests for CloudTrailProvider UpdateTrail."""

from __future__ import annotations

import pytest

from lws.providers.cloudtrail.provider import CloudTrailProvider


class TestCloudTrailProviderUpdateTrail:
    """UpdateTrail: S3 bucket and EventBridge ARN updates."""

    def test_update_trail_s3_bucket(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        provider.create_trail("trail", "original-bucket")
        expected_bucket = "new-bucket"

        # Act
        provider.update_trail("trail", s3_bucket=expected_bucket)

        # Assert
        actual = provider.get_trail("trail")
        assert actual.s3_bucket == expected_bucket

    def test_update_trail_eventbridge_arn(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        provider.create_trail("trail", "bucket")
        expected_arn = "arn:aws:events:us-east-1:000000000000:event-bus/my-bus"

        # Act
        provider.update_trail("trail", eventbridge_bus_arn=expected_arn)

        # Assert
        actual = provider.get_trail("trail")
        assert actual.eventbridge_bus_arn == expected_arn

    def test_update_trail_disable_eventbridge(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        provider.create_trail("trail", "bucket")
        long_arn = "arn:aws:events:us-east-1:000:event-bus/bus"
        provider.update_trail("trail", eventbridge_bus_arn=long_arn)

        # Act
        provider.update_trail("trail", eventbridge_bus_arn="")

        # Assert
        actual = provider.get_trail("trail")
        assert actual.eventbridge_bus_arn == ""

    def test_update_nonexistent_trail_raises(self) -> None:
        # Arrange
        provider = CloudTrailProvider()

        # Act
        # Assert
        with pytest.raises(KeyError, match="TrailNotFoundException"):
            provider.update_trail("no-such-trail", s3_bucket="bucket")
