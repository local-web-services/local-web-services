"""Unit tests for AwsCapacityConfig.is_exhausted property."""

from __future__ import annotations

from lws.providers._shared.aws_capacity import AwsCapacityConfig


class TestAwsCapacityConfigIsExhausted:
    def test_is_exhausted_when_slots_zero(self):
        # Arrange
        expected_exhausted = True
        config = AwsCapacityConfig(slots=0)

        # Act
        actual_exhausted = config.is_exhausted

        # Assert
        assert actual_exhausted == expected_exhausted

    def test_is_not_exhausted_when_slots_none(self):
        # Arrange
        expected_exhausted = False
        config = AwsCapacityConfig()

        # Act
        actual_exhausted = config.is_exhausted

        # Assert
        assert actual_exhausted == expected_exhausted

    def test_is_not_exhausted_when_slots_positive(self):
        # Arrange
        expected_exhausted = False
        config = AwsCapacityConfig(slots=5)

        # Act
        actual_exhausted = config.is_exhausted

        # Assert
        assert actual_exhausted == expected_exhausted
