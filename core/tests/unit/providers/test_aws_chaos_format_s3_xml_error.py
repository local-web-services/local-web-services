"""Unit tests for S3 XML error formatting."""

from __future__ import annotations

from lws.providers._shared.aws_chaos import AwsErrorSpec, format_s3_xml_error


class TestFormatS3XmlError:
    def test_returns_xml_with_code_and_message(self):
        # Arrange
        error = AwsErrorSpec(type="NoSuchKey", message="The specified key does not exist.")

        # Act
        response = format_s3_xml_error(error)

        # Assert
        expected_status = 404
        assert response.status_code == expected_status
        body = response.body.decode() if isinstance(response.body, bytes) else response.body
        assert "<Code>NoSuchKey</Code>" in body
        assert "<Message>The specified key does not exist.</Message>" in body
        expected_media_type = "application/xml"
        assert response.media_type == expected_media_type
