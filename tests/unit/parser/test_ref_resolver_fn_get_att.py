"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

from lws.parser.ref_resolver import RefResolver


class TestFnGetAtt:
    def test_get_att_list_form(self):
        r = RefResolver(resource_map={"MyTable": "orders-table"})
        result = r.resolve({"Fn::GetAtt": ["MyTable", "Arn"]})
        assert result == "orders-table.Arn"

    def test_get_att_string_form(self):
        r = RefResolver(resource_map={"MyTable": "orders-table"})
        result = r.resolve({"Fn::GetAtt": "MyTable.StreamArn"})
        assert result == "orders-table.StreamArn"

    def test_get_att_generates_arn(self):
        r = RefResolver(resource_types={"Tbl": "AWS::DynamoDB::Table"})
        result = r.resolve({"Fn::GetAtt": ["Tbl", "Arn"]})
        assert result == "arn:ldk:dynamodb:local:000000000000:table/Tbl.Arn"
