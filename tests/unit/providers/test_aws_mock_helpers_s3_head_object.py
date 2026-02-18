from __future__ import annotations

from lws.providers._shared.aws_mock_helpers import expand_helpers


class TestS3HeadObject:
    def test_head_object_returns_headers(self) -> None:
        # Arrange
        helpers = {"content_type": "application/pdf", "content_length": 1024}
        expected_status = 200
        expected_content_type_header = "application/pdf"
        expected_content_length_header = "1024"

        # Act
        actual_response = expand_helpers("s3", "head-object", helpers)

        # Assert
        assert actual_response.status == expected_status
        actual_content_type_header = actual_response.headers["Content-Type"]
        actual_content_length_header = actual_response.headers["Content-Length"]
        assert actual_content_type_header == expected_content_type_header
        assert actual_content_length_header == expected_content_length_header
