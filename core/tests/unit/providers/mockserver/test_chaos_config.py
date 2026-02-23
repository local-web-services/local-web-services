"""Unit tests for ChaosConfig defaults."""

from __future__ import annotations

from lws.providers.mockserver.models import ChaosConfig


class TestChaosConfig:
    def test_default_chaos_disabled(self):
        # Arrange
        # (nothing to arrange)

        # Act
        chaos = ChaosConfig()

        # Assert
        assert chaos.enabled is False
        assert chaos.error_rate == 0.0
        assert chaos.latency_min_ms == 0
        assert chaos.latency_max_ms == 0
