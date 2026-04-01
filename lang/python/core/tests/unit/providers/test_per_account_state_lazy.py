"""Unit tests: PerAccountStateRegistry lazily instantiates state."""

from __future__ import annotations

from lws.providers._shared.per_account_state import PerAccountStateRegistry


class TestPerAccountStateLazyInstantiation:
    def test_factory_not_called_before_first_get(self) -> None:
        # Arrange
        call_count = 0

        def counting_factory() -> dict:
            nonlocal call_count
            call_count += 1
            return {}

        # Act
        _registry: PerAccountStateRegistry[dict] = PerAccountStateRegistry(counting_factory)

        # Assert
        actual_call_count = call_count
        expected_call_count = 0
        assert actual_call_count == expected_call_count

    def test_factory_called_once_per_account(self) -> None:
        # Arrange
        call_count = 0

        def counting_factory() -> dict:
            nonlocal call_count
            call_count += 1
            return {}

        registry: PerAccountStateRegistry[dict] = PerAccountStateRegistry(counting_factory)

        # Act
        registry.get("111111111111")
        registry.get("111111111111")
        registry.get("222222222222")

        # Assert
        actual_call_count = call_count
        expected_call_count = 2
        assert actual_call_count == expected_call_count

    def test_same_state_returned_on_repeated_get(self) -> None:
        # Arrange
        registry: PerAccountStateRegistry[dict] = PerAccountStateRegistry(dict)

        # Act
        first_state = registry.get("111111111111")
        second_state = registry.get("111111111111")

        # Assert
        assert first_state is second_state
