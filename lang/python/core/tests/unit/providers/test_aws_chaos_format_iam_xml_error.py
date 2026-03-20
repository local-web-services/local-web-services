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
        assert (
            response.status_code == expected_status
        ), f"Expected {expected_status!r} but got {response.status_code!r}"
        body = response.body.decode() if isinstance(response.body, bytes) else response.body
        assert "<ErrorResponse>" in body, f'Expected {"<ErrorResponse>"!r} to be in {body!r}'
        assert (
            "<Code>NoSuchEntity</Code>" in body
        ), f'Expected {"<Code>NoSuchEntity</Code>"!r} to be in {body!r}'
        assert (
            "<Message>Entity not found</Message>" in body
        ), f'Expected {"<Message>Entity not found</Message>"!r} to be in {body!r}'
        expected_media_type = "text/xml"
        assert (
            response.media_type == expected_media_type
        ), f"Expected {expected_media_type!r} but got {response.media_type!r}"
