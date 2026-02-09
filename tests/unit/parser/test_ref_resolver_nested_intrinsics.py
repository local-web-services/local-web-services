"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

from lws.parser.ref_resolver import RefResolver


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
