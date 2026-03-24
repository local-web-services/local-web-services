"""Unit tests: CapacityBuilder.unlimited() sets slots to None."""

from __future__ import annotations

from lws_testing._builders.capacity import CapacityBuilder


class TestCapacityBuilderUnlimited:
    def test_unlimited_sets_slots_to_none(self):
        # Arrange
        builder = CapacityBuilder("sqs", 9000)
        builder.exhaust()
        expected_slots = None

        # Act
        builder.unlimited()

        # Assert
        actual_slots = builder._config["slots"]
        assert actual_slots == expected_slots

    def test_unlimited_returns_self_for_chaining(self):
        # Arrange
        builder = CapacityBuilder("sqs", 9000)

        # Act
        actual_result = builder.unlimited()

        # Assert
        assert actual_result is builder
