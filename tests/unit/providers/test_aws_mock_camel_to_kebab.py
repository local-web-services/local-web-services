"""Unit tests for camel_to_kebab function."""

from __future__ import annotations

from lws.providers._shared.aws_operation_mock import camel_to_kebab


class TestCamelToKebab:
    def test_get_item(self):
        # Arrange
        expected_result = "get-item"

        # Act
        actual_result = camel_to_kebab("GetItem")

        # Assert
        assert actual_result == expected_result

    def test_list_objects_v2(self):
        # Arrange
        expected_result = "list-objects-v2"

        # Act
        actual_result = camel_to_kebab("ListObjectsV2")

        # Assert
        assert actual_result == expected_result

    def test_put_parameter(self):
        # Arrange
        expected_result = "put-parameter"

        # Act
        actual_result = camel_to_kebab("PutParameter")

        # Assert
        assert actual_result == expected_result

    def test_create_secret(self):
        # Arrange
        expected_result = "create-secret"

        # Act
        actual_result = camel_to_kebab("CreateSecret")

        # Assert
        assert actual_result == expected_result

    def test_single_word_scan(self):
        # Arrange
        expected_result = "scan"

        # Act
        actual_result = camel_to_kebab("Scan")

        # Assert
        assert actual_result == expected_result
