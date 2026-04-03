"""Unit tests: ServiceDescriptor — dataclass constructor."""

from __future__ import annotations

from lws.providers._shared.service_descriptor import ServiceDescriptor


class TestServiceDescriptor:
    def test_descriptor_holds_name_and_factory(self) -> None:
        # Arrange
        expected_name = "test-service"

        def _factory(**_):
            return None, None

        # Act
        desc = ServiceDescriptor(name=expected_name, factory=_factory)

        # Assert
        actual_name = desc.name
        assert actual_name == expected_name
        assert desc.factory is _factory
