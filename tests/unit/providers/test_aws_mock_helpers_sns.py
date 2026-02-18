from __future__ import annotations

from lws.providers._shared.aws_mock_helpers import expand_helpers


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
        assert actual_response.status == 200
        assert actual_response.content_type == expected_content_type
        assert expected_root_element in actual_response.body
        assert f"<MessageId>{expected_message_id}</MessageId>" in actual_response.body
