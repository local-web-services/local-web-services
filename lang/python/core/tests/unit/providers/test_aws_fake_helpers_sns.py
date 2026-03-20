from __future__ import annotations

from lws.providers._shared.aws_fake_helpers import expand_helpers


class TestSNSPublish:
    def test_publish_returns_xml_with_message_id(self) -> None:
        # Arrange
        helpers = {"message_id": "msg-001"}
        expected_message_id = "msg-001"
        expected_content_type = "application/xml"
        expected_root_element = "<PublishResponse>"

        # Act
        actual_response = expand_helpers("sns", "publish", helpers)

        # Assert
        assert actual_response.status == 200, f"Expected {200!r} but got {actual_response.status!r}"
        assert actual_response.content_type == expected_content_type, f"Expected {expected_content_type!r} but got {actual_response.content_type!r}"
        assert expected_root_element in actual_response.body, f"Expected {expected_root_element!r} to be in {actual_response.body!r}"
        assert f"<MessageId>{expected_message_id}</MessageId>" in actual_response.body, "Expected {0!r} to be in {1!r}".format(f"<MessageId>{expected_message_id}</MessageId>", actual_response.body)
