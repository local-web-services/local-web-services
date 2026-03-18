"""Unit tests for _matches_resource in iam_policy_engine."""

from __future__ import annotations

from lws.providers._shared.iam_policy_engine import _matches_resource


class TestMatchesResource:
    def test_wildcard(self):
        # Arrange
        pattern = "*"
        resource = "arn:aws:s3:::my-bucket/key"

        # Act
        actual = _matches_resource(pattern, resource)

        # Assert
        assert actual is True

    def test_arn_wildcard(self):
        # Arrange
        pattern = "arn:aws:s3:::my-bucket/*"
        resource = "arn:aws:s3:::my-bucket/foo.txt"

        # Act
        actual = _matches_resource(pattern, resource)

        # Assert
        assert actual is True

    def test_no_match(self):
        # Arrange
        pattern = "arn:aws:s3:::other-bucket/*"
        resource = "arn:aws:s3:::my-bucket/foo.txt"

        # Act
        actual = _matches_resource(pattern, resource)

        # Assert
        assert actual is False
