"""Unit tests for _matches_action in iam_policy_engine."""

from __future__ import annotations

from lws.providers._shared.iam_policy_engine import _matches_action


class TestMatchesAction:
    def test_exact_match(self):
        # Arrange
        pattern = "s3:GetObject"
        action = "s3:GetObject"

        # Act
        actual = _matches_action(pattern, action)

        # Assert
        assert actual is True

    def test_wildcard_all(self):
        # Arrange
        pattern = "*"
        action = "s3:GetObject"

        # Act
        actual = _matches_action(pattern, action)

        # Assert
        assert actual is True

    def test_service_wildcard(self):
        # Arrange
        pattern = "s3:*"
        action = "s3:GetObject"

        # Act
        actual = _matches_action(pattern, action)

        # Assert
        assert actual is True

    def test_no_match(self):
        # Arrange
        pattern = "s3:PutObject"
        action = "s3:GetObject"

        # Act
        actual = _matches_action(pattern, action)

        # Assert
        assert actual is False

    def test_case_insensitive(self):
        # Arrange
        pattern = "S3:getobject"
        action = "s3:GetObject"

        # Act
        actual = _matches_action(pattern, action)

        # Assert
        assert actual is True
