"""Unit tests for AWS_ERROR_STATUS_CODES registry."""

from __future__ import annotations

from lws.providers._shared.aws_chaos import AWS_ERROR_STATUS_CODES


class TestAwsErrorStatusCodes:
    def test_common_errors_have_expected_status(self):
        # Arrange
        expected_mappings = {
            "ResourceNotFoundException": 404,
            "AccessDeniedException": 403,
            "LimitExceededException": 429,
            "NoSuchKey": 404,
            "ConditionalCheckFailedException": 400,
            "ServiceUnavailableException": 503,
            "InternalServerError": 500,
        }

        # Act
        actual_mappings = {k: AWS_ERROR_STATUS_CODES[k] for k in expected_mappings}

        # Assert
        assert actual_mappings == expected_mappings
