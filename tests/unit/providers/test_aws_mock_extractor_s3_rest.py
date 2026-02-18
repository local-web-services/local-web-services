"""Unit tests for _extractor_s3_rest."""

from __future__ import annotations

from starlette.requests import Request

from lws.providers._shared.aws_operation_mock import _extractor_s3_rest


def _make_request(
    method: str = "GET",
    path: str = "/",
    headers: list[tuple[bytes, bytes]] | None = None,
    query_string: bytes = b"",
) -> Request:
    """Create a minimal Starlette Request from a scope dict."""
    scope = {
        "type": "http",
        "method": method,
        "path": path,
        "headers": headers or [],
        "query_string": query_string,
    }
    return Request(scope)


class TestExtractorS3Rest:
    def test_get_root_returns_list_buckets(self):
        # Arrange
        extractor = _extractor_s3_rest()
        request = _make_request(method="GET", path="/")
        expected_operation = "list-buckets"

        # Act
        actual_operation = extractor(request, b"")

        # Assert
        assert actual_operation == expected_operation

    def test_put_bucket_returns_create_bucket(self):
        # Arrange
        extractor = _extractor_s3_rest()
        request = _make_request(method="PUT", path="/mybucket")
        expected_operation = "create-bucket"

        # Act
        actual_operation = extractor(request, b"")

        # Assert
        assert actual_operation == expected_operation

    def test_get_bucket_returns_list_objects_v2(self):
        # Arrange
        extractor = _extractor_s3_rest()
        request = _make_request(method="GET", path="/mybucket")
        expected_operation = "list-objects-v2"

        # Act
        actual_operation = extractor(request, b"")

        # Assert
        assert actual_operation == expected_operation

    def test_get_object_returns_get_object(self):
        # Arrange
        extractor = _extractor_s3_rest()
        request = _make_request(method="GET", path="/mybucket/mykey")
        expected_operation = "get-object"

        # Act
        actual_operation = extractor(request, b"")

        # Assert
        assert actual_operation == expected_operation

    def test_put_object_returns_put_object(self):
        # Arrange
        extractor = _extractor_s3_rest()
        request = _make_request(method="PUT", path="/mybucket/mykey")
        expected_operation = "put-object"

        # Act
        actual_operation = extractor(request, b"")

        # Assert
        assert actual_operation == expected_operation

    def test_delete_object_returns_delete_object(self):
        # Arrange
        extractor = _extractor_s3_rest()
        request = _make_request(method="DELETE", path="/mybucket/mykey")
        expected_operation = "delete-object"

        # Act
        actual_operation = extractor(request, b"")

        # Assert
        assert actual_operation == expected_operation

    def test_head_object_returns_head_object(self):
        # Arrange
        extractor = _extractor_s3_rest()
        request = _make_request(method="HEAD", path="/mybucket/mykey")
        expected_operation = "head-object"

        # Act
        actual_operation = extractor(request, b"")

        # Assert
        assert actual_operation == expected_operation
