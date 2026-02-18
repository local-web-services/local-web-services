from __future__ import annotations

from lws.providers._shared.aws_mock_helpers import expand_helpers


class TestS3GetObject:
    def test_get_object_with_body_string(self) -> None:
        # Arrange
        helpers = {"body_string": "hello world", "content_type": "text/plain"}
        expected_body = "hello world"
        expected_content_type = "text/plain"

        # Act
        actual_response = expand_helpers("s3", "get-object", helpers)

        # Assert
        assert actual_response.status == 200
        assert actual_response.body == expected_body
        assert actual_response.content_type == expected_content_type

    def test_get_object_with_body_file(self, tmp_path) -> None:
        # Arrange
        file = tmp_path / "data.txt"
        file.write_text("file content", encoding="utf-8")
        helpers = {"body_file": "data.txt", "content_type": "text/plain"}
        expected_body = "file content"

        # Act
        actual_response = expand_helpers("s3", "get-object", helpers, mock_dir=tmp_path)

        # Assert
        assert actual_response.status == 200
        assert actual_response.body == expected_body
