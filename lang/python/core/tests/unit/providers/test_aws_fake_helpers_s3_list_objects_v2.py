from __future__ import annotations

from lws.providers._shared.aws_fake_helpers import expand_helpers


class TestS3ListObjectsV2:
    def test_list_objects_returns_xml_with_contents(self) -> None:
        # Arrange
        helpers = {"keys": ["doc/a.pdf", "doc/b.pdf"]}
        expected_content_type = "application/xml"

        # Act
        actual_response = expand_helpers("s3", "list-objects-v2", helpers)

        # Assert
        assert actual_response.status == 200, f"Expected {200!r} but got {actual_response.status!r}"
        assert actual_response.content_type == expected_content_type, (
            f"Expected {expected_content_type!r} but got {actual_response.content_type!r}"
        )
        assert "<Key>doc/a.pdf</Key>" in actual_response.body, (
            f'Expected {"<Key>doc/a.pdf</Key>"!r} to be in {actual_response.body!r}'
        )
        assert "<Key>doc/b.pdf</Key>" in actual_response.body, (
            f'Expected {"<Key>doc/b.pdf</Key>"!r} to be in {actual_response.body!r}'
        )
        assert "<KeyCount>2</KeyCount>" in actual_response.body, (
            f'Expected {"<KeyCount>2</KeyCount>"!r} to be in {actual_response.body!r}'
        )
