"""Unit tests for format_error dispatch function."""

from __future__ import annotations

from lws.providers._shared.aws_chaos import AwsErrorSpec, ErrorFormat, format_error


class TestFormatError:
    def test_json_format(self):
        # Arrange
        error = AwsErrorSpec(type="ResourceNotFoundException", message="Not found")

        # Act
        response = format_error(error, ErrorFormat.JSON)

        # Assert
        expected_media_type = "application/x-amz-json-1.0"
        assert response.media_type == expected_media_type

    def test_s3_xml_format(self):
        # Arrange
        error = AwsErrorSpec(type="NoSuchKey", message="Not found")

        # Act
        response = format_error(error, ErrorFormat.XML_S3)

        # Assert
        expected_media_type = "application/xml"
        assert response.media_type == expected_media_type

    def test_iam_xml_format(self):
        # Arrange
        error = AwsErrorSpec(type="NoSuchEntity", message="Not found")

        # Act
        response = format_error(error, ErrorFormat.XML_IAM)

        # Assert
        expected_media_type = "text/xml"
        assert response.media_type == expected_media_type
