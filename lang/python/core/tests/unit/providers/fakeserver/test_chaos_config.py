"""Unit tests for ChaosConfig defaults."""

from __future__ import annotations

from lws.providers.fakeserver.models import ChaosConfig


class TestChaosConfig:
    def test_default_chaos_disabled(self):
        # Arrange
        # (nothing to arrange)

        # Act
        chaos = ChaosConfig()

        # Assert
        assert chaos.enabled is False, "Expected value to be truthy"
        assert chaos.error_rate == 0.0, f"Expected {0.0!r} but got {chaos.error_rate!r}"
        assert chaos.latency_min_ms == 0, f"Expected {0!r} but got {chaos.latency_min_ms!r}"
        assert chaos.latency_max_ms == 0, f"Expected {0!r} but got {chaos.latency_max_ms!r}"
