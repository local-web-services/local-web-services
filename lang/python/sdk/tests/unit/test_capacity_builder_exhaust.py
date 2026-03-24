"""Unit tests: CapacityBuilder.exhaust() sets slots to 0."""

from __future__ import annotations

from lws_testing._builders.capacity import CapacityBuilder


class TestCapacityBuilderExhaust:
    def test_exhaust_sets_slots_to_zero(self):
        # Arrange
        builder = CapacityBuilder("stepfunctions", 9000)
        expected_slots = 0

        # Act
        builder.exhaust()

        # Assert
        actual_slots = builder._config["slots"]
        assert actual_slots == expected_slots

    def test_exhaust_returns_self_for_chaining(self):
        # Arrange
        builder = CapacityBuilder("stepfunctions", 9000)

        # Act
        actual_result = builder.exhaust()

        # Assert
        assert actual_result is builder
