"""Unit tests for extract_operation_info in GraphQL handler."""

from __future__ import annotations

from lws.providers.fakeserver.graphql_handler import extract_operation_info


class TestExtractOperationInfo:
    def test_query_operation(self):
        # Arrange
        body = {
            "query": "query GetUser { user { id name } }",
            "variables": {"id": "u1"},
        }

        # Act
        op_type, field_name, variables = extract_operation_info(body)

        # Assert
        expected_type = "Query"
        assert op_type == expected_type, f"Expected {expected_type!r} but got {op_type!r}"
        expected_field = "user"
        assert field_name == expected_field, f"Expected {expected_field!r} but got {field_name!r}"
        assert variables == {"id": "u1"}, (
            "Expected {!r} but got {!r}".format({"id": "u1"}, variables)
        )

    def test_mutation_operation(self):
        # Arrange
        body = {
            "query": "mutation CreateUser { createUser { id } }",
            "variables": {},
        }

        # Act
        op_type, field_name, _variables = extract_operation_info(body)

        # Assert
        expected_type = "Mutation"
        assert op_type == expected_type, f"Expected {expected_type!r} but got {op_type!r}"

    def test_operation_name_from_body(self):
        # Arrange
        body = {
            "query": "{ user { id } }",
            "operationName": "GetUser",
        }

        # Act
        _op_type, field_name, _variables = extract_operation_info(body)

        # Assert
        expected_field = "user"
        assert field_name == expected_field, f"Expected {expected_field!r} but got {field_name!r}"
