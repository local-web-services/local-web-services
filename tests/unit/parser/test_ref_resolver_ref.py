"""Tests for ldk.parser.ref_resolver."""

from __future__ import annotations

from lws.parser.ref_resolver import RefResolver


class TestRef:
    def test_pseudo_param_account_id(self):
        # Arrange
        expected_account_id = "000000000000"
        r = RefResolver()

        # Act
        actual_value = r.resolve({"Ref": "AWS::AccountId"})

        # Assert
        assert actual_value == expected_account_id

    def test_pseudo_param_region(self):
        # Arrange
        expected_region = "local"
        r = RefResolver()

        # Act
        actual_value = r.resolve({"Ref": "AWS::Region"})

        # Assert
        assert actual_value == expected_region

    def test_ref_with_resource_map(self):
        # Arrange
        expected_value = "my-local-bucket"
        r = RefResolver(resource_map={"MyBucket": expected_value})

        # Act
        actual_value = r.resolve({"Ref": "MyBucket"})

        # Assert
        assert actual_value == expected_value

    def test_ref_unknown_generates_arn(self):
        # Arrange
        expected_arn = "arn:ldk:lambda:local:000000000000:function/MyFunc"
        r = RefResolver(resource_types={"MyFunc": "AWS::Lambda::Function"})

        # Act
        actual_value = r.resolve({"Ref": "MyFunc"})

        # Assert
        assert actual_value == expected_arn

    def test_ref_unknown_no_type(self):
        # Arrange
        expected_arn = "arn:ldk:unknown:local:000000000000:resource/SomeLogicalId"
        r = RefResolver()

        # Act
        actual_value = r.resolve({"Ref": "SomeLogicalId"})

        # Assert
        assert actual_value == expected_arn
