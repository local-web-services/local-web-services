"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

from lws.parser.ref_resolver import RefResolver


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
