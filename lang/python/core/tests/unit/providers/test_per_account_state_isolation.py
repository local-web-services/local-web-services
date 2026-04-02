"""Unit tests: PerAccountStateRegistry isolates state between accounts."""

from __future__ import annotations

from lws.providers._shared.per_account_state import PerAccountStateRegistry


class TestPerAccountStateIsolation:
    def test_write_to_account_a_does_not_affect_account_b(self) -> None:
        # Arrange
        registry: PerAccountStateRegistry[dict] = PerAccountStateRegistry(dict)

        # Act
        registry.get("111111111111")["key"] = "value-a"

        # Assert
        actual_b_state = registry.get("222222222222")
        assert "key" not in actual_b_state

    def test_write_to_account_b_does_not_affect_account_a(self) -> None:
        # Arrange
        registry: PerAccountStateRegistry[dict] = PerAccountStateRegistry(dict)
        registry.get("111111111111")["shared-key"] = "from-a"

        # Act
        registry.get("222222222222")["shared-key"] = "from-b"

        # Assert
        actual_a_value = registry.get("111111111111")["shared-key"]
        expected_a_value = "from-a"
        assert actual_a_value == expected_a_value
