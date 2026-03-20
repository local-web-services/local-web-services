from __future__ import annotations

from lws.providers._shared.aws_fake_helpers import expand_helpers


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
        assert actual_response.status == 200, f"Expected {200!r} but got {actual_response.status!r}"
        assert actual_response.content_type == expected_content_type, f"Expected {expected_content_type!r} but got {actual_response.content_type!r}"
        assert expected_root_element in actual_response.body, f"Expected {expected_root_element!r} to be in {actual_response.body!r}"
        assert expected_message_element in actual_response.body, f"Expected {expected_message_element!r} to be in {actual_response.body!r}"
        assert f"<Body>{expected_body_content}</Body>" in actual_response.body, "Expected {0!r} to be in {1!r}".format(f"<Body>{expected_body_content}</Body>", actual_response.body)
