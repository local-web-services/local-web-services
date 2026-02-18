from __future__ import annotations

from lws.providers._shared.aws_mock_helpers import expand_helpers


class TestSQSReceiveMessage:
    def test_receive_message_returns_xml_with_message(self) -> None:
        # Arrange
        helpers = {"messages": [{"body": '{"orderId": "abc"}'}]}
        expected_body_content = '{"orderId": "abc"}'
        expected_content_type = "application/xml"
        expected_root_element = "<ReceiveMessageResponse>"
        expected_message_element = "<Message>"

        # Act
        actual_response = expand_helpers("sqs", "receive-message", helpers)

        # Assert
        assert actual_response.status == 200
        assert actual_response.content_type == expected_content_type
        assert expected_root_element in actual_response.body
        assert expected_message_element in actual_response.body
        assert f"<Body>{expected_body_content}</Body>" in actual_response.body
