from __future__ import annotations

from lws.providers._shared.aws_mock_helpers import simple_json_to_dynamodb_json


class TestSimpleJsonToDynamoDBJson:
    def test_string_value(self) -> None:
        # Arrange
        expected_result = {"name": {"S": "value"}}

        # Act
        actual_result = simple_json_to_dynamodb_json({"name": "value"})

        # Assert
        assert actual_result == expected_result

    def test_integer_value(self) -> None:
        # Arrange
        expected_result = {"age": {"N": "30"}}

        # Act
        actual_result = simple_json_to_dynamodb_json({"age": 30})

        # Assert
        assert actual_result == expected_result

    def test_float_value(self) -> None:
        # Arrange
        expected_result = {"pi": {"N": "3.14"}}

        # Act
        actual_result = simple_json_to_dynamodb_json({"pi": 3.14})

        # Assert
        assert actual_result == expected_result

    def test_boolean_true(self) -> None:
        # Arrange
        expected_result = {"active": {"BOOL": True}}

        # Act
        actual_result = simple_json_to_dynamodb_json({"active": True})

        # Assert
        assert actual_result == expected_result

    def test_boolean_false(self) -> None:
        # Arrange
        expected_result = {"active": {"BOOL": False}}

        # Act
        actual_result = simple_json_to_dynamodb_json({"active": False})

        # Assert
        assert actual_result == expected_result

    def test_list_of_strings(self) -> None:
        # Arrange
        expected_result = {"tags": {"L": [{"S": "a"}, {"S": "b"}]}}

        # Act
        actual_result = simple_json_to_dynamodb_json({"tags": ["a", "b"]})

        # Assert
        assert actual_result == expected_result

    def test_none_value(self) -> None:
        # Arrange
        expected_result = {"deleted": {"NULL": True}}

        # Act
        actual_result = simple_json_to_dynamodb_json({"deleted": None})

        # Assert
        assert actual_result == expected_result

    def test_nested_dict(self) -> None:
        # Arrange
        expected_result = {"address": {"M": {"city": {"S": "London"}, "zip": {"S": "SW1"}}}}

        # Act
        actual_result = simple_json_to_dynamodb_json({"address": {"city": "London", "zip": "SW1"}})

        # Assert
        assert actual_result == expected_result
