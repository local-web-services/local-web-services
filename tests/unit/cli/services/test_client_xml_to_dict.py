"""Unit tests for xml_to_dict."""

from __future__ import annotations

from lws.cli.services.client import xml_to_dict


class TestXmlToDict:
    def test_simple_xml(self):
        xml = (
            "<SendMessageResponse>"
            "<SendMessageResult>"
            "<MessageId>abc123</MessageId>"
            "</SendMessageResult>"
            "</SendMessageResponse>"
        )
        result = xml_to_dict(xml)
        assert "SendMessageResponse" in result
        inner = result["SendMessageResponse"]
        assert inner["SendMessageResult"]["MessageId"] == "abc123"

    def test_empty_elements(self):
        xml = "<Response><Empty></Empty></Response>"
        result = xml_to_dict(xml)
        assert result["Response"]["Empty"] == ""
