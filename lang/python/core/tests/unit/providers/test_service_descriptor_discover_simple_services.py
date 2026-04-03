"""Unit tests: ServiceDescriptor — discover_simple_services."""

from __future__ import annotations

from lws.providers._shared.service_descriptor import discover_simple_services


class TestDiscoverSimpleServices:
    def test_discovers_all_four_simple_services(self) -> None:
        # Arrange
        expected_names = {"cloudformation", "organizations", "servicecatalog", "sts"}

        # Act
        descriptors = discover_simple_services()

        # Assert
        actual_names = {d.name for d in descriptors}
        assert actual_names == expected_names

    def test_results_sorted_alphabetically(self) -> None:
        # Arrange
        # (no setup needed)

        # Act
        descriptors = discover_simple_services()

        # Assert
        actual_names = [d.name for d in descriptors]
        expected_names = sorted(actual_names)
        assert actual_names == expected_names

    def test_non_descriptor_modules_excluded(self) -> None:
        # Arrange
        # dynamodb has no DESCRIPTOR

        # Act
        descriptors = discover_simple_services()

        # Assert
        actual_names = {d.name for d in descriptors}
        assert "dynamodb" not in actual_names

    def test_each_descriptor_has_callable_factory(self) -> None:
        # Arrange
        # (no setup needed)

        # Act
        descriptors = discover_simple_services()

        # Assert
        for desc in descriptors:
            assert callable(desc.factory), f"{desc.name} factory is not callable"
