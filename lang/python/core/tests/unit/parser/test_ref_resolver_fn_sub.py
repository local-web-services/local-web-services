"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

from lws.parser.ref_resolver import RefResolver


class TestFnSub:
    def test_sub_simple_string(self):
        # Arrange
        expected_value = "arn:aws:lambda:local:000000000000:my-function"
        r = RefResolver(resource_map={"MyFunc": "my-function"})

        # Act
        actual_value = r.resolve(
            {"Fn::Sub": "arn:aws:lambda:${AWS::Region}:${AWS::AccountId}:${MyFunc}"}
        )

        # Assert
        assert actual_value == expected_value

    def test_sub_with_variables(self):
        # Arrange
        expected_value = "Hello World"
        r = RefResolver()

        # Act
        actual_value = r.resolve({"Fn::Sub": ["Hello ${Name}", {"Name": "World"}]})

        # Assert
        assert actual_value == expected_value

    def test_sub_with_nested_ref(self):
        # Arrange
        expected_value = "s3://local-bucket"
        r = RefResolver(resource_map={"Bucket": "local-bucket"})

        # Act
        actual_value = r.resolve(
            {"Fn::Sub": ["s3://${BucketRef}", {"BucketRef": {"Ref": "Bucket"}}]}
        )

        # Assert
        assert actual_value == expected_value

    def test_sub_unresolvable_generates_arn(self):
        # Act
        r = RefResolver()
        actual_value = r.resolve({"Fn::Sub": "prefix-${Unknown}"})

        # Assert
        assert "arn:ldk:" in actual_value
        assert "Unknown" in actual_value
