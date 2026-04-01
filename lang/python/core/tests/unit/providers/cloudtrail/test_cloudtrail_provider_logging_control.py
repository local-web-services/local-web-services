"""Tests for CloudTrailProvider StartLogging, StopLogging, and idempotency."""

from __future__ import annotations

import pytest

from lws.providers.cloudtrail.provider import CloudTrailProvider


class TestCloudTrailProviderLoggingControl:
    """StartLogging / StopLogging state transitions."""

    def test_start_logging_enables_logging(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        provider.create_trail("trail", "bucket")

        # Act
        provider.start_logging("trail")

        # Assert
        actual = provider.get_trail("trail")
        assert actual.logging is True

    def test_stop_logging_disables_logging(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        provider.create_trail("trail", "bucket")
        provider.start_logging("trail")

        # Act
        provider.stop_logging("trail")

        # Assert
        actual = provider.get_trail("trail")
        assert actual.logging is False

    def test_start_logging_idempotent(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        provider.create_trail("trail", "bucket")
        provider.start_logging("trail")

        # Act — call again, should not raise
        provider.start_logging("trail")

        # Assert
        actual = provider.get_trail("trail")
        assert actual.logging is True

    def test_start_logging_unknown_trail_raises(self) -> None:
        # Arrange
        provider = CloudTrailProvider()

        # Act
        # Assert
        with pytest.raises(KeyError, match="TrailNotFoundException"):
            provider.start_logging("no-such-trail")

    def test_stop_logging_unknown_trail_raises(self) -> None:
        # Arrange
        provider = CloudTrailProvider()

        # Act
        # Assert
        with pytest.raises(KeyError, match="TrailNotFoundException"):
            provider.stop_logging("no-such-trail")

    def test_deleted_trail_not_logging(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        provider.create_trail("trail", "bucket")
        provider.start_logging("trail")

        # Act
        provider.delete_trail("trail")

        # Assert
        with pytest.raises(KeyError, match="TrailNotFoundException"):
            provider.get_trail("trail")
