"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

from lws.parser.ref_resolver import RefResolver


class TestNestedIntrinsics:
    def test_nested_sub_in_join(self):
        # Arrange
        expected_value = "arn:aws:lambda:local:my-func"
        r = RefResolver(resource_map={"Fn": "my-func"})

        # Act
        actual_value = r.resolve(
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

        # Assert
        assert actual_value == expected_value

    def test_deeply_nested(self):
        # Arrange
        expected_value = "s3:/bucket"
        r = RefResolver(conditions={"Go": True}, resource_map={"B": "bucket"})

        # Act
        actual_value = r.resolve(
            {
                "Fn::If": [
                    "Go",
                    {"Fn::Join": ["/", ["s3:", {"Ref": "B"}]]},
                    "fallback",
                ]
            }
        )

        # Assert
        assert actual_value == expected_value
