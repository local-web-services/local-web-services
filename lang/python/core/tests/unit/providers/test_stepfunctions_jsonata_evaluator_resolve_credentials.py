"""Tests for resolve_credentials."""

from __future__ import annotations

from lws.providers.stepfunctions.jsonata_evaluator import resolve_credentials


class TestResolveCredentials:
    def test_dynamic_role_arn_is_evaluated(self) -> None:
        # Arrange
        expected_arn = "arn:aws:iam::123456789012:role/MyRole"
        credentials = {"RoleArn": "{% $states.input.roleArn %}"}
        input_data = {"roleArn": expected_arn}

        # Act
        actual_result = resolve_credentials(credentials, input_data)

        # Assert
        assert actual_result["RoleArn"] == expected_arn

    def test_static_role_arn_is_returned_unchanged(self) -> None:
        # Arrange
        expected_arn = "arn:aws:iam::123456789012:role/Fixed"
        credentials = {"RoleArn": expected_arn}
        input_data = {}

        # Act
        actual_result = resolve_credentials(credentials, input_data)

        # Assert
        assert actual_result["RoleArn"] == expected_arn

    def test_credentials_with_variables(self) -> None:
        # Arrange
        expected_arn = "arn:aws:iam::111111111111:role/Dynamic"
        credentials = {"RoleArn": "{% $states.context.variables.roleArn %}"}
        input_data = {}
        variables = {"roleArn": expected_arn}

        # Act
        actual_result = resolve_credentials(credentials, input_data, variables=variables)

        # Assert
        assert actual_result["RoleArn"] == expected_arn
