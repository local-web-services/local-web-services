"""Unit tests for _pick_error_status in chaos middleware."""

from __future__ import annotations

from lws.providers.mockserver.chaos import _pick_error_status
from lws.providers.mockserver.models import ChaosConfig


class TestPickErrorStatus:
    def test_no_status_codes_returns_500(self):
        # Arrange
        chaos = ChaosConfig(enabled=True, error_rate=1.0)
        expected_status = 500

        # Act
        actual_status = _pick_error_status(chaos)

        # Assert
        assert actual_status == expected_status

    def test_with_status_codes(self):
        # Arrange
        chaos = ChaosConfig(
            enabled=True,
            error_rate=1.0,
            status_codes=[
                {"status": 503, "weight": 1.0},
            ],
        )
        expected_status = 503

        # Act
        actual_status = _pick_error_status(chaos)

        # Assert
        assert actual_status == expected_status
