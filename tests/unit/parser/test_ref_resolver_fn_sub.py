"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

from lws.parser.ref_resolver import RefResolver


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
