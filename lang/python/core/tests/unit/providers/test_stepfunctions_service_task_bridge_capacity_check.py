"""Tests for the ServiceTaskBridge._check_capacity helper method."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeExhaustedCapacity, FakeUnlimitedCapacity


class TestCapacityCheckHelper:
    """Unit tests for the _check_capacity static method."""

    def test_returns_when_capacity_is_none(self) -> None:
        # Arrange
        # Act
        # Assert — no exception raised
        ServiceTaskBridge._check_capacity(None, "TestService")

    def test_returns_when_capacity_unlimited(self) -> None:
        # Arrange
        capacity = FakeUnlimitedCapacity()

        # Act
        # Assert — no exception raised
        ServiceTaskBridge._check_capacity(capacity, "TestService")

    def test_raises_when_capacity_exhausted(self) -> None:
        # Arrange
        capacity = FakeExhaustedCapacity()
        expected_error = "TestService capacity is exhausted"

        # Act / Assert
        with pytest.raises(RuntimeError, match=expected_error):
            ServiceTaskBridge._check_capacity(capacity, "TestService")
