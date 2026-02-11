"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

from lws.parser.ref_resolver import RefResolver


class TestFnGetAtt:
    def test_get_att_list_form(self):
        # Arrange
        expected_value = "orders-table.Arn"
        r = RefResolver(resource_map={"MyTable": "orders-table"})

        # Act
        actual_value = r.resolve({"Fn::GetAtt": ["MyTable", "Arn"]})

        # Assert
        assert actual_value == expected_value

    def test_get_att_string_form(self):
        # Arrange
        expected_value = "orders-table.StreamArn"
        r = RefResolver(resource_map={"MyTable": "orders-table"})

        # Act
        actual_value = r.resolve({"Fn::GetAtt": "MyTable.StreamArn"})

        # Assert
        assert actual_value == expected_value

    def test_get_att_generates_arn(self):
        # Arrange
        expected_arn = "arn:ldk:dynamodb:local:000000000000:table/Tbl.Arn"
        r = RefResolver(resource_types={"Tbl": "AWS::DynamoDB::Table"})

        # Act
        actual_value = r.resolve({"Fn::GetAtt": ["Tbl", "Arn"]})

        # Assert
        assert actual_value == expected_arn
