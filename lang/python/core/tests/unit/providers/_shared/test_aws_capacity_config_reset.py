"""Unit tests for AwsCapacityConfig.reset method."""

from __future__ import annotations

from lws.providers._shared.aws_capacity import AwsCapacityConfig


class TestAwsCapacityConfigReset:
    def test_reset_clears_slots(self):
        # Arrange
        config = AwsCapacityConfig(slots=0)
        expected_slots = None

        # Act
        config.reset()

        # Assert
        actual_slots = config.slots
        assert actual_slots == expected_slots
