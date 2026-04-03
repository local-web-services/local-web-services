"""Tests for Service Catalog _ScState."""

from __future__ import annotations

from lws.providers.service_catalog._sc_state import _DEFAULT_PRODUCT_ID, _ScState


class TestScState:
    def test_initial_state_has_default_product_seeded(self) -> None:
        # Arrange
        expected_product_id = _DEFAULT_PRODUCT_ID

        # Act
        state = _ScState()

        # Assert
        actual_has_product = expected_product_id in state.products
        assert actual_has_product, f"Expected default product {expected_product_id!r} to be seeded"

    def test_products_property_returns_store(self) -> None:
        # Arrange
        state = _ScState()

        # Act
        actual_products = state.products

        # Assert
        expected_type = dict
        assert isinstance(
            actual_products, expected_type
        ), f"Expected products to be a {expected_type!r} but got {type(actual_products)!r}"

    def test_records_property_returns_store(self) -> None:
        # Arrange
        state = _ScState()

        # Act
        actual_records = state.records

        # Assert
        expected_type = dict
        assert isinstance(
            actual_records, expected_type
        ), f"Expected records to be a {expected_type!r} but got {type(actual_records)!r}"

    def test_reset_re_seeds_default_product(self) -> None:
        # Arrange
        state = _ScState()
        state.products.clear()
        state.records["rec-test"] = "dummy"  # type: ignore[assignment]
        expected_product_id = _DEFAULT_PRODUCT_ID
        expected_record_count = 0

        # Act
        state.reset()

        # Assert
        actual_has_product = expected_product_id in state.products
        assert actual_has_product, f"Expected default product {expected_product_id!r} after reset"
        actual_record_count = len(state.records)
        assert actual_record_count == expected_record_count, (
            f"Expected {expected_record_count!r} records after reset "
            f"but got {actual_record_count!r}"
        )
