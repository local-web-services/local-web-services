"""Unit tests: CapacityBuilder.slots() sets slot count."""

from __future__ import annotations

from lws_testing._builders.capacity import CapacityBuilder


class TestCapacityBuilderSlots:
    def test_slots_stores_value(self):
        # Arrange
        builder = CapacityBuilder("dynamodb", 9000)
        expected_slots = 5

        # Act
        builder.slots(expected_slots)

        # Assert
        actual_slots = builder._config["slots"]
        assert actual_slots == expected_slots

    def test_slots_returns_self_for_chaining(self):
        # Arrange
        builder = CapacityBuilder("dynamodb", 9000)

        # Act
        actual_result = builder.slots(5)

        # Assert
        assert actual_result is builder
