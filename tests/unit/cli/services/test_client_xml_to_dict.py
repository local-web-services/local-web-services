"""Unit tests for xml_to_dict."""

from __future__ import annotations

from lws.cli.services.client import xml_to_dict


class TestXmlToDict:
    def test_simple_xml(self):
        # Arrange
        expected_message_id = "abc123"
        expected_root_key = "SendMessageResponse"
        xml = (
            f"<{expected_root_key}>"
            "<SendMessageResult>"
            f"<MessageId>{expected_message_id}</MessageId>"
            "</SendMessageResult>"
            f"</{expected_root_key}>"
        )

        # Act
        result = xml_to_dict(xml)

        # Assert
        assert expected_root_key in result
        actual_message_id = result[expected_root_key]["SendMessageResult"]["MessageId"]
        assert actual_message_id == expected_message_id

    def test_empty_elements(self):
        # Arrange
        expected_empty_value = ""
        xml = "<Response><Empty></Empty></Response>"

        # Act
        result = xml_to_dict(xml)
        actual_empty_value = result["Response"]["Empty"]

        # Assert
        assert actual_empty_value == expected_empty_value
