"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

import logging

from ldk.parser.ref_resolver import RefResolver


class TestRef:
    def test_pseudo_param_account_id(self):
        r = RefResolver()
        assert r.resolve({"Ref": "AWS::AccountId"}) == "000000000000"

    def test_pseudo_param_region(self):
        r = RefResolver()
        assert r.resolve({"Ref": "AWS::Region"}) == "local"

    def test_ref_with_resource_map(self):
        r = RefResolver(resource_map={"MyBucket": "my-local-bucket"})
        assert r.resolve({"Ref": "MyBucket"}) == "my-local-bucket"

    def test_ref_unknown_generates_arn(self):
        r = RefResolver(resource_types={"MyFunc": "AWS::Lambda::Function"})
        result = r.resolve({"Ref": "MyFunc"})
        assert result == "arn:ldk:lambda:local:000000000000:function/MyFunc"

    def test_ref_unknown_no_type(self):
        r = RefResolver()
        result = r.resolve({"Ref": "SomeLogicalId"})
        assert result == "arn:ldk:unknown:local:000000000000:resource/SomeLogicalId"


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


class TestFnSub:
    def test_sub_simple_string(self):
        r = RefResolver(resource_map={"MyFunc": "my-function"})
        result = r.resolve({"Fn::Sub": "arn:aws:lambda:${AWS::Region}:${AWS::AccountId}:${MyFunc}"})
        assert result == "arn:aws:lambda:local:000000000000:my-function"

    def test_sub_with_variables(self):
        r = RefResolver()
        result = r.resolve({"Fn::Sub": ["Hello ${Name}", {"Name": "World"}]})
        assert result == "Hello World"

    def test_sub_with_nested_ref(self):
        r = RefResolver(resource_map={"Bucket": "local-bucket"})
        result = r.resolve({"Fn::Sub": ["s3://${BucketRef}", {"BucketRef": {"Ref": "Bucket"}}]})
        assert result == "s3://local-bucket"

    def test_sub_unresolvable_generates_arn(self):
        r = RefResolver()
        result = r.resolve({"Fn::Sub": "prefix-${Unknown}"})
        assert "arn:ldk:" in result
        assert "Unknown" in result


class TestFnJoin:
    def test_join_basic(self):
        r = RefResolver()
        result = r.resolve({"Fn::Join": ["-", ["a", "b", "c"]]})
        assert result == "a-b-c"

    def test_join_with_refs(self):
        r = RefResolver(resource_map={"X": "hello"})
        result = r.resolve({"Fn::Join": ["/", ["prefix", {"Ref": "X"}, "suffix"]]})
        assert result == "prefix/hello/suffix"

    def test_join_empty_delimiter(self):
        r = RefResolver()
        result = r.resolve({"Fn::Join": ["", ["abc", "def"]]})
        assert result == "abcdef"


class TestFnSelect:
    def test_select_basic(self):
        r = RefResolver()
        result = r.resolve({"Fn::Select": [1, ["a", "b", "c"]]})
        assert result == "b"

    def test_select_zero_index(self):
        r = RefResolver()
        result = r.resolve({"Fn::Select": [0, ["first", "second"]]})
        assert result == "first"

    def test_select_out_of_range(self, caplog):
        r = RefResolver()
        with caplog.at_level(logging.WARNING):
            result = r.resolve({"Fn::Select": [5, ["a"]]})
        assert result == ""
        assert "out of range" in caplog.text


class TestFnIf:
    def test_if_true(self):
        r = RefResolver(conditions={"IsProd": True})
        result = r.resolve({"Fn::If": ["IsProd", "prod-value", "dev-value"]})
        assert result == "prod-value"

    def test_if_false(self):
        r = RefResolver(conditions={"IsProd": False})
        result = r.resolve({"Fn::If": ["IsProd", "prod-value", "dev-value"]})
        assert result == "dev-value"

    def test_if_unknown_condition_defaults_true(self):
        r = RefResolver()
        result = r.resolve({"Fn::If": ["UnknownCond", "yes", "no"]})
        assert result == "yes"

    def test_if_with_nested_intrinsics(self):
        r = RefResolver(
            conditions={"UseCustom": True},
            resource_map={"Custom": "custom-val"},
        )
        result = r.resolve({"Fn::If": ["UseCustom", {"Ref": "Custom"}, "default"]})
        assert result == "custom-val"


class TestNestedIntrinsics:
    def test_nested_sub_in_join(self):
        r = RefResolver(resource_map={"Fn": "my-func"})
        result = r.resolve(
            {
                "Fn::Join": [
                    ":",
                    [
                        {"Fn::Sub": "arn:aws:lambda:${AWS::Region}"},
                        {"Ref": "Fn"},
                    ],
                ]
            }
        )
        assert result == "arn:aws:lambda:local:my-func"

    def test_deeply_nested(self):
        r = RefResolver(conditions={"Go": True}, resource_map={"B": "bucket"})
        result = r.resolve(
            {
                "Fn::If": [
                    "Go",
                    {"Fn::Join": ["/", ["s3:", {"Ref": "B"}]]},
                    "fallback",
                ]
            }
        )
        assert result == "s3:/bucket"


class TestNonIntrinsicStructures:
    def test_plain_string_passthrough(self):
        r = RefResolver()
        assert r.resolve("hello") == "hello"

    def test_plain_int_passthrough(self):
        r = RefResolver()
        assert r.resolve(42) == 42

    def test_plain_dict_values_resolved(self):
        r = RefResolver(resource_map={"X": "val"})
        result = r.resolve({"Key": {"Ref": "X"}, "Other": "literal"})
        assert result == {"Key": "val", "Other": "literal"}

    def test_list_elements_resolved(self):
        r = RefResolver(resource_map={"A": "a_val"})
        result = r.resolve([{"Ref": "A"}, "plain"])
        assert result == ["a_val", "plain"]


class TestWarnings:
    def test_unresolvable_get_att_warns(self, caplog):
        r = RefResolver()
        with caplog.at_level(logging.WARNING):
            r.resolve({"Fn::GetAtt": 42})
        assert "Unresolvable Fn::GetAtt" in caplog.text

    def test_bad_join_warns(self, caplog):
        r = RefResolver()
        with caplog.at_level(logging.WARNING):
            r.resolve({"Fn::Join": "not-a-list"})
        assert "Unresolvable Fn::Join" in caplog.text
