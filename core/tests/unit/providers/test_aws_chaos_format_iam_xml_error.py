"""Unit tests for IAM XML error formatting."""

from __future__ import annotations

from lws.providers._shared.aws_chaos import AwsErrorSpec, format_iam_xml_error


class TestFormatIamXmlError:
    def test_returns_error_response_xml(self):
        # Arrange
        error = AwsErrorSpec(type="NoSuchEntity", message="Entity not found")

        # Act
        response = format_iam_xml_error(error)

        # Assert
        expected_status = 404
        assert response.status_code == expected_status
        body = response.body.decode() if isinstance(response.body, bytes) else response.body
        assert "<ErrorResponse>" in body
        assert "<Code>NoSuchEntity</Code>" in body
        assert "<Message>Entity not found</Message>" in body
        expected_media_type = "text/xml"
        assert response.media_type == expected_media_type
